From: Iago Abal <iari-YidNj35/HaM@public.gmane.org>
Subject: Re: [PATCH] iommu: fix double spin_lock_irqsave on
	`device_domain_lock'
Date: Fri, 4 Nov 2016 10:38:29 +0100
Message-ID: <CAGbDTvqDAEcLPNxHa6wvjTwpotDbZSSDL3MocVgj=LTMFG8Okw@mail.gmail.com>
References: <1476694480-4251-1-git-send-email-iari@itu.dk>
	<20161103205136.GA4930@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161103205136.GA4930-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 3, 2016 at 9:51 PM, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org> wrote:
>
> No, you can't just release the lock to re-aquire it in
> dmar_remove_one_dev_info(). This introduces new races, as the list your
> are walking is no longer protected by the lock. The right solution is to
> call a variant of dmar_remove_one_dev_info() which does not take the
> lock. It turns out this function already exists, so the patch looks like
> below. Can you check if this is still correct and resubmit your patch?
>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index a4407ea..3cadde2 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1723,7 +1723,7 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
>
>                 domain = info->domain;
>
> -               dmar_remove_one_dev_info(domain, info->dev);
> +               __dmar_remove_one_dev_info(info);
>
>                 if (!domain_type_is_vm_or_si(domain))
>                         domain_exit(domain);


That patch was actually my first attempt at fixing the problem, but I
ran the tool and I found a second possibility of deadlock:
`domain_exit' calls to `domain_remove_dev_info', which also spin_locks
on `device_domain_lock'.

Alternatively I could add another `__domain_exit' function that
doesn't take the lock.

Would that be fine?

-- iago
