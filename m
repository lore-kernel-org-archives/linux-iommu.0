Return-Path: <SRS0=V6zV=XV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D70DC432C2
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 06:37:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F25E206E0
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 06:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPjSbpse"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F25E206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DB53DB4B;
	Thu, 26 Sep 2019 06:37:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C62AB941
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 06:37:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com
	(us-smtp-delivery-1.mimecast.com [207.211.31.120])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 4C0D68D
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 06:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1569479826;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=28jgCHf3Y31AfX11rLNCTs8yKIYceWAI65+4FKf05Jo=;
	b=RPjSbpseQMboXdRg4kfnQWZrRcPWZMn1JW7C+xq3BtIvrPsHFVM8CjBVfPQX9dR7zSgIA2
	WPZanod1Ha4ZqFfyc/gBave/++FkGT/lxy+f0WDjvvSONQw1DfEM0v+6tyTuIyIOcLoc1z
	IswvBTfsrH/N6xlOYatwaVddfr8G7kE=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
	[209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
	us-mta-303-j3y8ghPANFilFdLnFXJmlA-1; Thu, 26 Sep 2019 02:37:04 -0400
Received: by mail-io1-f70.google.com with SMTP id m3so2771464ion.11
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 23:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=bzg5Snd+WZpcq1+9IS+DAm3OOz0eaOup3zxF7UeRy4c=;
	b=QezZwFEE5Iyx9dLt8+ZisCg3+Dk0Df0dGFsbb/Np2v496ZDedr4f2Xe8QDUhNiKnTP
	FyfCyKOiXj7rIUjZin3UkONGmQTtjgfTUMOhvFUU67D3gAQYDZMXIAWkPQmvBK6TZRGM
	EcmC/HAJlHOqxYU9MRay5ycXfg43gm80ZhsvxZCqceuwYDEaMt8L5bdgIEu9AwQx79fz
	zbZJ90YIuS7yW9z9UD3Cuq5Zq516nTAJBBO6rtogfutKfV/TmgQ9ckYb5QVLJ61Y1TvZ
	uh9ISpnYKG4lnNs846HyLwaYMmsiYty+twS7E4Nko5uKGaSA5GqKKf0lGOQeSub0V/wM
	rrzA==
X-Gm-Message-State: APjAAAWzjd5U7beOWLKNKCqpAjS2qBliVvptcfMAMH22TzwRufil0XFY
	vggWrJbJC3hnR/DBJppNpRqNkwawLBp/uL0pOdxM8Ete53OTI2xXvqYdEx68C05nzaYC2qAOv3j
	gRsgcAeEGLf7wJBVNOmSYzMW1xAO1Ng==
X-Received: by 2002:a5e:c241:: with SMTP id w1mr1933812iop.36.1569479823964;
	Wed, 25 Sep 2019 23:37:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy5fisyD5zDOY8PFJxspSRU0FGqLrwKF2ItZi0TFPQrLYlMCzndqsMirM3e3Tdv54bhVZxqDA==
X-Received: by 2002:a5e:c241:: with SMTP id w1mr1933799iop.36.1569479823778;
	Wed, 25 Sep 2019 23:37:03 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
	by smtp.gmail.com with ESMTPSA id p20sm680769iod.43.2019.09.25.23.37.02
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 25 Sep 2019 23:37:03 -0700 (PDT)
Date: Wed, 25 Sep 2019 23:37:01 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 4/6] iommu/amd: Check for busy devices earlier in
	attach_device()
Message-ID: <20190926063701.drppvoo6nztxtbjq@cantor>
References: <20190925132300.3038-1-joro@8bytes.org>
	<20190925132300.3038-5-joro@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20190925132300.3038-5-joro@8bytes.org>
User-Agent: NeoMutt/20180716
X-MC-Unique: j3y8ghPANFilFdLnFXJmlA-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
Cc: Filippo Sironi <sironi@amazon.de>, iommu@lists.linux-foundation.org,
	jroedel@suse.de
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Wed Sep 25 19, Joerg Roedel wrote:
>From: Joerg Roedel <jroedel@suse.de>
>
>Check early in attach_device whether the device is already attached to a
>domain. This also simplifies the code path so that __attach_device() can
>be removed.
>
>Fixes: 92d420ec028d ("iommu/amd: Relax locking in dma_ops path")
>Signed-off-by: Joerg Roedel <jroedel@suse.de>
>---
> drivers/iommu/amd_iommu.c | 25 +++++++------------------
> 1 file changed, 7 insertions(+), 18 deletions(-)
>
>diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>index 2919168577ff..459247c32dc0 100644
>--- a/drivers/iommu/amd_iommu.c
>+++ b/drivers/iommu/amd_iommu.c
>@@ -2072,23 +2072,6 @@ static void do_detach(struct iommu_dev_data *dev_data)
> 	domain->dev_cnt                 -= 1;
> }
>
>-/*
>- * If a device is not yet associated with a domain, this function makes the
>- * device visible in the domain
>- */
>-static int __attach_device(struct iommu_dev_data *dev_data,
>-			   struct protection_domain *domain)
>-{
>-	if (dev_data->domain != NULL)
>-		return -EBUSY;
>-
>-	/* Attach alias group root */
>-	do_attach(dev_data, domain);
>-
>-	return 0;
>-}
>-
>-
> static void pdev_iommuv2_disable(struct pci_dev *pdev)
> {
> 	pci_disable_ats(pdev);
>@@ -2174,6 +2157,10 @@ static int attach_device(struct device *dev,
>
> 	dev_data = get_dev_data(dev);
>
>+	ret = -EBUSY;
>+	if (dev_data->domain != NULL)
>+		goto out;
>+
> 	if (!dev_is_pci(dev))
> 		goto skip_ats_check;
>
>@@ -2198,7 +2185,9 @@ static int attach_device(struct device *dev,
> 	}
>
> skip_ats_check:
>-	ret = __attach_device(dev_data, domain);
>+	ret = 0;
>+
>+	do_attach(dev_data, domain);
>
> 	/*
> 	 * We might boot into a crash-kernel here. The crashed kernel
>-- 
>2.17.1
>
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
