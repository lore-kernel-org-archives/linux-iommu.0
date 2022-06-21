Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897EBC43334
	for <iommu@archiver.kernel.org>; Tue, 21 Jun 2022 22:46:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0183E40C21;
	Tue, 21 Jun 2022 22:46:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0183E40C21
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AyRJcZIe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qcjQNVX1MDyM; Tue, 21 Jun 2022 22:46:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 68E2C4056C;
	Tue, 21 Jun 2022 22:46:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 68E2C4056C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3882AC0039;
	Tue, 21 Jun 2022 22:46:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E9D7C002D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 22:46:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 347C340A38
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 22:46:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 347C340A38
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hTgw-a_NtWPS for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 22:46:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 38D254011A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 38D254011A
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 22:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655851568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/+1/Xy/oMl85EwlznQPMBlg4SJKLxQKry9nxTTQZbw=;
 b=AyRJcZIekxYC76QJjRkzyo7H6zsDdELYhefvVWlhYiyOXa9dJXi5a+8JCAhjUQQZKVbGFc
 Gsu3/DQCk2Db4Kpg8yawNgBSkv3LriWupYki7UIkzhb+K7SwRGwdJMG75ZYAU01beixfH2
 MMllBSRbmiiWKemHxO3w6pMaknU6HiE=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-LgByjRwuNcO01RUjOwuUSg-1; Tue, 21 Jun 2022 18:46:06 -0400
X-MC-Unique: LgByjRwuNcO01RUjOwuUSg-1
Received: by mail-io1-f70.google.com with SMTP id
 x13-20020a0566022c4d00b0065491fa5614so8297295iov.9
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 15:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=f/+1/Xy/oMl85EwlznQPMBlg4SJKLxQKry9nxTTQZbw=;
 b=78IPwrrNT3AwXze+Fp0mOYDa0nBODw7bAFlr9J6u0vKWEEHoSFd9CwZPQ6vv0ZnAYa
 I8JsvfBRCl7NC/rbKrG4XeVgqIOvaG96lG4+mIuZx/qnK43tOKBeH85zvlMyViX8xDxw
 q1MXLCQL+9PRvBKDjJCiNYuaqfIBJMXm/4B9mR/bS+cSl38YUAit6y7BHEkAn6hOlTTN
 j2W9U3Wn79HdBb7kf8CMu68tU+YhuMHBXLwrYEL22IbirHM2eCKVuGPOdGc7MW91uuqL
 t6mhGuCjpgrOcMD9jG8eQyXz9jfJU3oD8Za8VIYAzuZE8Hk2PQhWgZ8WoyFa5tzvU7H/
 U3xQ==
X-Gm-Message-State: AJIora9ClfuGCKALXOzG5mZpoid5SJfpGfomEr3v0pf/lYefqiW8sicG
 KNyKFD3QQxUkxLirsDNT6zqk4VsyZ6kYB8OWvfq/la8y/CvfltFKL9MDitohnYbDD9AQN9LNE1S
 44WV6eDamEt1LbsaJc6iNsPbR1yU3Ew==
X-Received: by 2002:a6b:ba43:0:b0:669:a9b2:48fb with SMTP id
 k64-20020a6bba43000000b00669a9b248fbmr192957iof.125.1655851566099; 
 Tue, 21 Jun 2022 15:46:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tCBBV2lQEfTtXWwkhfe9gHC1iihjOMaGFwTYEcz2D9BCipjXjT/6swp6lkrYHefJSlpm5AwA==
X-Received: by 2002:a6b:ba43:0:b0:669:a9b2:48fb with SMTP id
 k64-20020a6bba43000000b00669a9b248fbmr192927iof.125.1655851565803; 
 Tue, 21 Jun 2022 15:46:05 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 m3-20020a056638224300b00339c015fd84sm2073679jas.59.2022.06.21.15.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jun 2022 15:46:05 -0700 (PDT)
Date: Tue, 21 Jun 2022 16:46:02 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 2/5] vfio/iommu_type1: Prefer to reuse domains vs
 match enforced cache coherency
Message-ID: <20220621164602.4079bf43.alex.williamson@redhat.com>
In-Reply-To: <20220616000304.23890-3-nicolinc@nvidia.com>
References: <20220616000304.23890-1-nicolinc@nvidia.com>
 <20220616000304.23890-3-nicolinc@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-s390@vger.kernel.org, cohuck@redhat.com, jordan@cosmicpenguin.net,
 linux-tegra@vger.kernel.org, thierry.reding@gmail.com, will@kernel.org,
 alyssa@rosenzweig.io, jean-philippe@linaro.org,
 saiprakash.ranjan@codeaurora.org, kvm@vger.kernel.org, zhang.lyra@gmail.com,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com,
 linux-arm-kernel@lists.infradead.org, jgg@nvidia.com, yangyingliang@huawei.com,
 orsonzhai@gmail.com, gerald.schaefer@linux.ibm.com, kevin.tian@intel.com,
 linux-arm-msm@vger.kernel.org, christophe.jaillet@wanadoo.fr,
 matthias.bgg@gmail.com, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org, isaacm@codeaurora.org,
 dwmw2@infradead.org, marcan@marcan.st, linux-kernel@vger.kernel.org,
 baolin.wang7@gmail.com, linux-mediatek@lists.infradead.org,
 robin.murphy@arm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, 15 Jun 2022 17:03:01 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> The KVM mechanism for controlling wbinvd is based on OR of the coherency
> property of all devices attached to a guest, no matter those devices are
> attached to a single domain or multiple domains.
> 
> So, there is no value in trying to push a device that could do enforced
> cache coherency to a dedicated domain vs re-using an existing domain
> which is non-coherent since KVM won't be able to take advantage of it.
> This just wastes domain memory.
> 
> Simplify this code and eliminate the test. This removes the only logic
> that needed to have a dummy domain attached prior to searching for a
> matching domain and simplifies the next patches.
> 
> It's unclear whether we want to further optimize the Intel driver to
> update the domain coherency after a device is detached from it, at
> least not before KVM can be verified to handle such dynamics in related
> emulation paths (wbinvd, vcpu load, write_cr0, ept, etc.). In reality
> we don't see an usage requiring such optimization as the only device
> which imposes such non-coherency is Intel GPU which even doesn't
> support hotplug/hot remove.

The 2nd paragraph above is quite misleading in this respect.  I think
it would be more accurate to explain that the benefit to using separate
domains was that devices attached to domains supporting enforced cache
coherency always mapped with the attributes necessary to provide that
feature, therefore if a non-enforced domain was dropped, the associated
group removal would re-trigger an evaluation by KVM.  We can then go on
to discuss that in practice the only known cases of such mixed domains
included an Intel IGD device behind an IOMMU lacking snoop control,
where such devices do not support hotplug, therefore this scenario lacks
testing and is not considered sufficiently relevant to support.  Thanks,

Alex

> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index c13b9290e357..f4e3b423a453 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2285,9 +2285,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	 * testing if they're on the same bus_type.
>  	 */
>  	list_for_each_entry(d, &iommu->domain_list, next) {
> -		if (d->domain->ops == domain->domain->ops &&
> -		    d->enforce_cache_coherency ==
> -			    domain->enforce_cache_coherency) {
> +		if (d->domain->ops == domain->domain->ops) {
>  			iommu_detach_group(domain->domain, group->iommu_group);
>  			if (!iommu_attach_group(d->domain,
>  						group->iommu_group)) {

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
