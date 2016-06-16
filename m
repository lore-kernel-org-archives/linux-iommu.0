From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [BUGREPORT] Intel X58 Boards don't boot after "iommu/vt-d: Make
	root entry visible for hardware right after allocation"
Date: Thu, 16 Jun 2016 12:29:14 +0200
Message-ID: <20160616102914.GA11432@8bytes.org>
References: <CAH-=PyRpjuKf0XJNyzkVLpggaaYq163AfA84SZ5=DQH2Ys5Lkw@mail.gmail.com>
	<CAH-=PyR-6sY1vuzQSfJyh35Q+WqZKD70Ev7vDns+02h8j=m18Q@mail.gmail.com>
	<20160425110151.GE17926@8bytes.org>
	<CAH-=PyTGF76sq7LvQH0-28DoK1dXGUOdnCF6z9shF_CWosWYwQ@mail.gmail.com>
	<CAH-=PyTaR-xH7D4eOnFkB-7gojdZW08yHEPP2Gw2-0GjWTA4dw@mail.gmail.com>
	<20160615161149.GJ13971@8bytes.org>
	<CAH-=PyRBZU95f0XPLZQXyaKLPx+K5iNsQs3ucQRj6BPfj9ERBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAH-=PyRBZU95f0XPLZQXyaKLPx+K5iNsQs3ucQRj6BPfj9ERBA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dheeraj CVR <cvr.dheeraj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 16, 2016 at 10:26:20AM +0400, Dheeraj CVR wrote:
> I have added some debugging code to see where exactly the hang happens. T=
he=A0
> set_root_entry call works fine without any issues as you have expected.
> However, the hang happens when calling flush_context.
> =

> flush_context -> qi_flush_context -> qi_submit_sync
> =

> The loop "while (qi->desc_status[wait_index] !=3D QI_DONE) {}" in
> "qi_submit_sync" executes indefinitely and the control doesn't break. Hen=
ce, "
> iommu->flush.flush_context()" never returns.
> =

> Tested on 2 X58 Motherboards and both hang at the same place with intel_i=
ommu=3D
> on.
> =

> Hope this helps.

Hmm, okay. Yesterday I tried to reproduce the problem on a box in our
test-lab which has the same chipset. The bug didn't show up there, and
one difference to your machine is that is only has one iommu instead of
two.

This brought me to another difference the patch made: Before the patch
QI was enabled on all iommus before the root entry was set and the
caches flushed. With the patch QI is enabled in the same loop that sets
the root entry and tries to flush. Maybe that is the problem on this
chipset.

Can you please try the attached diff? It is just a guess, but maybe that
is the problem.

Thanks,

	Joerg

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a644d0c..0ddbb6a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3222,11 +3222,6 @@ static int __init init_dmars(void)
 			}
 		}
 =

-		iommu_flush_write_buffer(iommu);
-		iommu_set_root_entry(iommu);
-		iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
-		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
-
 		if (!ecap_pass_through(iommu->ecap))
 			hw_pass_through =3D 0;
 #ifdef CONFIG_INTEL_IOMMU_SVM
@@ -3235,6 +3230,17 @@ static int __init init_dmars(void)
 #endif
 	}
 =

+	/*
+	 * Now that qi is enabled on all iommus, set the root entry and flush
+	 * caches.
+	 */
+	for_each_active_iommu(iommu, drhd) {
+		iommu_flush_write_buffer(iommu);
+		iommu_set_root_entry(iommu);
+		iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
+		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
+	}
+
 	if (iommu_pass_through)
 		iommu_identity_mapping |=3D IDENTMAP_ALL;
 =
