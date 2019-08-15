Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3A2C3A589
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 21:17:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6164E2083B
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 21:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAjHWRtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6164E2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1E2851207;
	Thu, 15 Aug 2019 21:17:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DC2371179
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 21:17:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
	[209.85.210.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5FE1B67F
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 21:17:57 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id i30so1943182pfk.9
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 14:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=euAnvJlLHwVUNWqq2xyGqSRGjCXD2Duyc9/+lj5jrdM=;
	b=YAjHWRtW3eRnYmQ932JYs9q3eRzTpat4T4ge8uPo+kqBuB27goMgfeDi36qWlmLDb7
	9m4B9SXumWgoAtKsKvrLuaw6osBlWEgP2+FZI54AlvdB8kHCxIDeHYYrg3LOKPW+He+2
	KzsobapzVAFEJs56O3gwSQNWJxo+ehjouFAJuIprBzu1P1lN554GjIhFVLupIHVDUnC1
	3cqWj26wPFyzB9n9FHOXUQ3OOlQK+h1ZAjutsMo+TCjgMqvRVJVvGhVTGygYiWv/q8RZ
	LrHIp7N8L3W0tn4MAXihdzVFR+3fggRzBW1XCbmSCbwMhIABBUmLOwTDMAxRvlDIm+Li
	aLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=euAnvJlLHwVUNWqq2xyGqSRGjCXD2Duyc9/+lj5jrdM=;
	b=GR0rZjeJ44ucg8rL1VPptfAP3Oa6fqS9fZ7O6tTYXRE8T7Di2driLoWtr/a2GUpi4p
	8JiPFpYzHsZPV7sh/nUlkvEvBqjl5o24VIOzwZVSPkaSAuIrE9lzl/PlVqe0yNxG6gma
	j6lw7WXy8ddR1E9O7i9BtFXHg9GHoZCLJ49M1YC5f65FGAMK5Aw4Zv4JJ6+ha7Ha+fTl
	TlpSR0bTziZcWOD2hCs10swUFBI08O+505y2+tWeaMUPs9eLU0vFWk6lJO+e6zgUWewj
	L1ca90yVHjSrg21wNzRS+9Ce5ltXDOGmoCx1H2+/v8IVzNRlibr2OKOP6r+goT/zouxF
	tWzA==
X-Gm-Message-State: APjAAAUUuF1Jay7Wm8voLNGdyvJbSTjPjukaaJQj+lgQJ3ST9cW9Nq/0
	VvbdjMDGovvQylhHyQRLj4krJVrL2ExKZZLKBHA=
X-Google-Smtp-Source: APXvYqxJJtdZgSXLEanOrlC8xqY0wjMqhsc/vj6RWI1cNg/RS0kRPQ0q2Lww/wl133yUbf0iQai3U9kADReUf0LJIDc=
X-Received: by 2002:a17:90a:a114:: with SMTP id
	s20mr4052992pjp.20.1565903876841; 
	Thu, 15 Aug 2019 14:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <1565900005-62508-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1565900005-62508-17-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1565900005-62508-17-git-send-email-jacob.jun.pan@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Aug 2019 00:17:44 +0300
Message-ID: <CAHp75VdD4SpA3oR8KBr6WihLkBgaaUn6f7tFdO7H-2n-hbun_Q@mail.gmail.com>
Subject: Re: [PATCH v5 16/19] iommu/vt-d: Misc macro clean up for SVM
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, Aug 15, 2019 at 11:52 PM Jacob Pan
<jacob.jun.pan@linux.intel.com> wrote:
>
> Use combined macros for_each_svm_dev() to simplify SVM device iteration
> and error checking.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/iommu/intel-svm.c | 85 +++++++++++++++++++++++------------------------
>  1 file changed, 41 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 5a688a5..ea6f2e2 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -218,6 +218,10 @@ static const struct mmu_notifier_ops intel_mmuops = {
>  static DEFINE_MUTEX(pasid_mutex);
>  static LIST_HEAD(global_svm_list);
>
> +#define for_each_svm_dev(svm, dev)                     \
> +       list_for_each_entry(sdev, &svm->devs, list)     \

> +       if (dev == sdev->dev)                           \

This should be
  if (dev != sdev->dev) {} else
and no trailing \ is neeeded.

The rationale of above form to avoid
for_each_foo() {
} else {
  ...WTF?!..
}

> +
>  int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
>  {
>         struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> @@ -263,15 +267,13 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
>                                 goto out;
>                         }
>
> -                       list_for_each_entry(sdev, &svm->devs, list) {
> -                               if (dev == sdev->dev) {
> -                                       if (sdev->ops != ops) {
> -                                               ret = -EBUSY;
> -                                               goto out;
> -                                       }
> -                                       sdev->users++;
> -                                       goto success;
> +                       for_each_svm_dev(svm, dev) {
> +                               if (sdev->ops != ops) {
> +                                       ret = -EBUSY;
> +                                       goto out;
>                                 }
> +                               sdev->users++;
> +                               goto success;
>                         }
>
>                         break;
> @@ -408,48 +410,43 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
>                 goto out;
>
>         svm = ioasid_find(NULL, pasid, NULL);
> -       if (IS_ERR(svm)) {
> +       if (IS_ERR_OR_NULL(svm)) {
>                 ret = PTR_ERR(svm);
>                 goto out;
>         }
>
> -       if (!svm)
> -               goto out;
> +       for_each_svm_dev(svm, dev) {
> +               ret = 0;
> +               sdev->users--;
> +               if (!sdev->users) {
> +                       list_del_rcu(&sdev->list);
> +                       /* Flush the PASID cache and IOTLB for this device.
> +                        * Note that we do depend on the hardware *not* using
> +                        * the PASID any more. Just as we depend on other
> +                        * devices never using PASIDs that they have no right
> +                        * to use. We have a *shared* PASID table, because it's
> +                        * large and has to be physically contiguous. So it's
> +                        * hard to be as defensive as we might like. */
> +                       intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
> +                       intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
> +                       kfree_rcu(sdev, rcu);
> +
> +                       if (list_empty(&svm->devs)) {
> +                               ioasid_free(svm->pasid);
> +                               if (svm->mm)
> +                                       mmu_notifier_unregister(&svm->notifier, svm->mm);
>
> -       list_for_each_entry(sdev, &svm->devs, list) {
> -               if (dev == sdev->dev) {
> -                       ret = 0;
> -                       sdev->users--;
> -                       if (!sdev->users) {
> -                               list_del_rcu(&sdev->list);
> -                               /* Flush the PASID cache and IOTLB for this device.
> -                                * Note that we do depend on the hardware *not* using
> -                                * the PASID any more. Just as we depend on other
> -                                * devices never using PASIDs that they have no right
> -                                * to use. We have a *shared* PASID table, because it's
> -                                * large and has to be physically contiguous. So it's
> -                                * hard to be as defensive as we might like. */
> -                               intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
> -                               intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
> -                               kfree_rcu(sdev, rcu);
> -
> -                               if (list_empty(&svm->devs)) {
> -                                       ioasid_free(svm->pasid);
> -                                       if (svm->mm)
> -                                               mmu_notifier_unregister(&svm->notifier, svm->mm);
> -
> -                                       list_del(&svm->list);
> -
> -                                       /* We mandate that no page faults may be outstanding
> -                                        * for the PASID when intel_svm_unbind_mm() is called.
> -                                        * If that is not obeyed, subtle errors will happen.
> -                                        * Let's make them less subtle... */
> -                                       memset(svm, 0x6b, sizeof(*svm));
> -                                       kfree(svm);
> -                               }
> +                               list_del(&svm->list);
> +
> +                               /* We mandate that no page faults may be outstanding
> +                                * for the PASID when intel_svm_unbind_mm() is called.
> +                                * If that is not obeyed, subtle errors will happen.
> +                                * Let's make them less subtle... */
> +                               memset(svm, 0x6b, sizeof(*svm));
> +                               kfree(svm);
>                         }
> -                       break;
>                 }
> +               break;
>         }
>   out:
>         mutex_unlock(&pasid_mutex);
> @@ -585,7 +582,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>                          * to unbind the mm while any page faults are outstanding.
>                          * So we only need RCU to protect the internal idr code. */
>                         rcu_read_unlock();
> -                       if (IS_ERR(svm) || !svm) {
> +                       if (IS_ERR_OR_NULL(svm)) {
>                                 pr_err("%s: Page request for invalid PASID %d: %08llx %08llx\n",
>                                        iommu->name, req->pasid, ((unsigned long long *)req)[0],
>                                        ((unsigned long long *)req)[1]);
> --
> 2.7.4
>


-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
