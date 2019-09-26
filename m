Return-Path: <SRS0=V6zV=XV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D60C432C2
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 06:34:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B192A206E0
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 06:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGYu2Frt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B192A206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7DD92B43;
	Thu, 26 Sep 2019 06:34:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A2C07B0B
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 06:34:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
	[205.139.110.120])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 080818AD
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 06:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1569479686;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=AWBW/jTcOEs9QNqdyh1D+NZo0tgbJeEEgYIKnEokU8M=;
	b=GGYu2FrtD2DeG8iy7A/z8w9zTYf2sofSPhVRF5gyp7DKk98JCe74TcPv1V09y5/A57JhHp
	IAGesf342nMbdkCX2XFnAaBRHm/GKt14mUzJyFAT3p9I3Pusa95PpQND0vp/+8+LY2bA+1
	558eQ9dwOVDMlZvYeHQDLT7IgvUoDjc=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
	[209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
	us-mta-240-AxtQ-1HuNS6zVoqbXMOOqg-1; Thu, 26 Sep 2019 02:34:45 -0400
Received: by mail-io1-f72.google.com with SMTP id x13so2708915ioa.18
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 23:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=gmBV34WJd5oIKiKbSjEBrwtz93y4EXfXGV9/mi5uZ1o=;
	b=Hu3LDN6nAgFAeJMLwbqZYj/PjrNeYgDMfh37IoD8+iym6k10yBvZYm7ry2VIyAdgBz
	rFb7XWhJmyKKU+KuIe2J1o6zn62QByfXsPOAMQT0qwVpYWCMN7bUND6Hqg0JBQ37fv1o
	PsRMAJN0TiFPXxieC8MsZoeyvBe+kWqLxttbggyOsnk+lDN0XhLSTbRYJAFiBaLOfA3k
	i5H0LF98jDHtigJpouuLMGV/V35P1BX+pCl6NeDJTw3pfzqRBtI3IMRp8y9Drfb/M3oj
	5K0Jv2Y8VhO1H0+D9nGbGkvWxdBB1HtvbE5Hw6rjC9PvmWkLavDMoCbqfKGpkC22cTYX
	P+gg==
X-Gm-Message-State: APjAAAXnenTEDJDdyfIWD2pjqP+bpU0YmCZi7veGMz3J5yEL0dSYRLTe
	RfJS3PGusGOfGvF7TQKS/71IfXNio2tTqijTYbMJJGONhZ0i6POEmVXQhntGXuGGJus9XWioHGT
	4dpQVGOv6g+levUODoh7t6T3bAGjnBw==
X-Received: by 2002:a92:47cf:: with SMTP id e76mr910255ilk.151.1569479682886; 
	Wed, 25 Sep 2019 23:34:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwgZ94rZpQpofwTGVrcDf7wImm2Lh9Z9JzQYvcBNVkXse4OH1/QENrmZlKvA829L11aAmPfvw==
X-Received: by 2002:a92:47cf:: with SMTP id e76mr910247ilk.151.1569479682669; 
	Wed, 25 Sep 2019 23:34:42 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
	by smtp.gmail.com with ESMTPSA id p81sm338555ilk.86.2019.09.25.23.34.41
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 25 Sep 2019 23:34:41 -0700 (PDT)
Date: Wed, 25 Sep 2019 23:34:40 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 3/6] iommu/amd: Take domain->lock for complete
	attach/detach path
Message-ID: <20190926063440.fvbq37qvqk7ukizf@cantor>
References: <20190925132300.3038-1-joro@8bytes.org>
	<20190925132300.3038-4-joro@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20190925132300.3038-4-joro@8bytes.org>
User-Agent: NeoMutt/20180716
X-MC-Unique: AxtQ-1HuNS6zVoqbXMOOqg-1
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
>The code-paths before __attach_device() and __detach_device() are called
>also access and modify domain state, so take the domain lock there too.
>This allows to get rid of the __detach_device() function.
>
>Fixes: 92d420ec028d ("iommu/amd: Relax locking in dma_ops path")
>Signed-off-by: Joerg Roedel <jroedel@suse.de>
>---
> drivers/iommu/amd_iommu.c | 65 ++++++++++++++++-----------------------
> 1 file changed, 26 insertions(+), 39 deletions(-)
>
>diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>index 37a9c04fc728..2919168577ff 100644
>--- a/drivers/iommu/amd_iommu.c
>+++ b/drivers/iommu/amd_iommu.c
>@@ -2079,27 +2079,13 @@ static void do_detach(struct iommu_dev_data *dev_data)
> static int __attach_device(struct iommu_dev_data *dev_data,
> 			   struct protection_domain *domain)
> {
>-	unsigned long flags;
>-	int ret;
>-
>-	/* lock domain */
>-	spin_lock_irqsave(&domain->lock, flags);
>-
>-	ret = -EBUSY;
> 	if (dev_data->domain != NULL)
>-		goto out_unlock;
>+		return -EBUSY;
>
> 	/* Attach alias group root */
> 	do_attach(dev_data, domain);
>
>-	ret = 0;
>-
>-out_unlock:
>-
>-	/* ready */
>-	spin_unlock_irqrestore(&domain->lock, flags);
>-
>-	return ret;
>+	return 0;
> }
>
>
>@@ -2181,8 +2167,11 @@ static int attach_device(struct device *dev,
> {
> 	struct pci_dev *pdev;
> 	struct iommu_dev_data *dev_data;
>+	unsigned long flags;
> 	int ret;
>
>+	spin_lock_irqsave(&domain->lock, flags);
>+
> 	dev_data = get_dev_data(dev);
>
> 	if (!dev_is_pci(dev))
>@@ -2190,12 +2179,13 @@ static int attach_device(struct device *dev,
>
> 	pdev = to_pci_dev(dev);
> 	if (domain->flags & PD_IOMMUV2_MASK) {
>+		ret = -EINVAL;
> 		if (!dev_data->passthrough)
>-			return -EINVAL;
>+			goto out;
>
> 		if (dev_data->iommu_v2) {
> 			if (pdev_iommuv2_enable(pdev) != 0)
>-				return -EINVAL;
>+				goto out;
>
> 			dev_data->ats.enabled = true;
> 			dev_data->ats.qdep    = pci_ats_queue_depth(pdev);
>@@ -2219,24 +2209,10 @@ static int attach_device(struct device *dev,
>
> 	domain_flush_complete(domain);
>
>-	return ret;
>-}
>-
>-/*
>- * Removes a device from a protection domain (unlocked)
>- */
>-static void __detach_device(struct iommu_dev_data *dev_data)
>-{
>-	struct protection_domain *domain;
>-	unsigned long flags;
>-
>-	domain = dev_data->domain;
>-
>-	spin_lock_irqsave(&domain->lock, flags);
>-
>-	do_detach(dev_data);
>-
>+out:
> 	spin_unlock_irqrestore(&domain->lock, flags);
>+
>+	return ret;
> }
>
> /*
>@@ -2246,10 +2222,13 @@ static void detach_device(struct device *dev)
> {
> 	struct protection_domain *domain;
> 	struct iommu_dev_data *dev_data;
>+	unsigned long flags;
>
> 	dev_data = get_dev_data(dev);
> 	domain   = dev_data->domain;
>
>+	spin_lock_irqsave(&domain->lock, flags);
>+
> 	/*
> 	 * First check if the device is still attached. It might already
> 	 * be detached from its domain because the generic
>@@ -2257,12 +2236,12 @@ static void detach_device(struct device *dev)
> 	 * our alias handling.
> 	 */
> 	if (WARN_ON(!dev_data->domain))
>-		return;
>+		goto out;
>
>-	__detach_device(dev_data);
>+	do_detach(dev_data);
>
> 	if (!dev_is_pci(dev))
>-		return;
>+		goto out;
>
> 	if (domain->flags & PD_IOMMUV2_MASK && dev_data->iommu_v2)
> 		pdev_iommuv2_disable(to_pci_dev(dev));
>@@ -2270,6 +2249,9 @@ static void detach_device(struct device *dev)
> 		pci_disable_ats(to_pci_dev(dev));
>
> 	dev_data->ats.enabled = false;
>+
>+out:
>+	spin_unlock_irqrestore(&domain->lock, flags);
> }
>
> static int amd_iommu_add_device(struct device *dev)
>@@ -2904,13 +2886,18 @@ int __init amd_iommu_init_dma_ops(void)
> static void cleanup_domain(struct protection_domain *domain)
> {
> 	struct iommu_dev_data *entry;
>+	unsigned long flags;
>+
>+	spin_lock_irqsave(&domain->lock, flags);
>
> 	while (!list_empty(&domain->dev_list)) {
> 		entry = list_first_entry(&domain->dev_list,
> 					 struct iommu_dev_data, list);
> 		BUG_ON(!entry->domain);
>-		__detach_device(entry);
>+		do_detach(entry);
> 	}
>+
>+	spin_unlock_irqrestore(&domain->lock, flags);
> }
>
> static void protection_domain_free(struct protection_domain *domain)
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
