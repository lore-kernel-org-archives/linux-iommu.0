From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] iommu/vt-d: Fix dead-locks in disable_dmar_iommu() path
Date: Tue, 8 Nov 2016 15:15:39 +0100
Message-ID: <20161108141539.GB3583@suse.de>
References: <1476694480-4251-1-git-send-email-iari@itu.dk>
	<20161103205136.GA4930@suse.de>
	<CAGbDTvqDAEcLPNxHa6wvjTwpotDbZSSDL3MocVgj=LTMFG8Okw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGbDTvqDAEcLPNxHa6wvjTwpotDbZSSDL3MocVgj=LTMFG8Okw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Iago Abal <iari-YidNj35/HaM@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 04, 2016 at 10:38:29AM +0100, Iago Abal wrote:
> That patch was actually my first attempt at fixing the problem, but I
> ran the tool and I found a second possibility of deadlock:
> `domain_exit' calls to `domain_remove_dev_info', which also spin_locks
> on `device_domain_lock'.
> 
> Alternatively I could add another `__domain_exit' function that
> doesn't take the lock.

So that is actually not easy to do, I'd rather go with the simpler
solution of dropping the lock for domain_exit() invocation and then
re-start walking the list afterwards, like in the below patch:

>From bea64033dd7b5fb6296eda8266acab6364ce1554 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Date: Tue, 8 Nov 2016 15:08:26 +0100
Subject: [PATCH] iommu/vt-d: Fix dead-locks in disable_dmar_iommu() path

It turns out that the disable_dmar_iommu() code-path tried
to get the device_domain_lock recursivly, which will
dead-lock when this code runs on dmar removal. Fix both
code-paths that could lead to the dead-lock.

Fixes: 55d940430ab9 ('iommu/vt-d: Get rid of domain->iommu_lock')
Reported-by: Iago Abal <iari-YidNj35/HaM@public.gmane.org>
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a4407ea..3965e73 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1711,6 +1711,7 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 	if (!iommu->domains || !iommu->domain_ids)
 		return;
 
+again:
 	spin_lock_irqsave(&device_domain_lock, flags);
 	list_for_each_entry_safe(info, tmp, &device_domain_list, global) {
 		struct dmar_domain *domain;
@@ -1723,10 +1724,19 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 
 		domain = info->domain;
 
-		dmar_remove_one_dev_info(domain, info->dev);
+		__dmar_remove_one_dev_info(info);
 
-		if (!domain_type_is_vm_or_si(domain))
+		if (!domain_type_is_vm_or_si(domain)) {
+			/*
+			 * The domain_exit() function  can't be called under
+			 * device_domain_lock, as it takes this lock itself.
+			 * So release the lock here and re-run the loop
+			 * afterwards.
+			 */
+			spin_unlock_irqrestore(&device_domain_lock, flags);
 			domain_exit(domain);
+			goto again;
+		}
 	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
-- 
2.6.6
