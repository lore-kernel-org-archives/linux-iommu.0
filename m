Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0488DC4338F
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 13:22:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA4660C41
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 13:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9FA4660C41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 686F583B5C;
	Fri, 30 Jul 2021 13:22:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XTdlmVAh1Bm2; Fri, 30 Jul 2021 13:22:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 55C4183495;
	Fri, 30 Jul 2021 13:22:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3021DC001A;
	Fri, 30 Jul 2021 13:22:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D40F0C000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 13:22:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C3DF760A83
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 13:22:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mailerdienst.de
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RmHkC3EyEp_p for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 13:22:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mxwww.masterlogin.de (mxwww.masterlogin.de
 [IPv6:2a03:2900:1:1::a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4CCB360A61
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 13:22:10 +0000 (UTC)
Received: from mxout3.routing.net (unknown [192.168.10.111])
 by backup.mxwww.masterlogin.de (Postfix) with ESMTPS id 7AC5E2C57F
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 13:18:14 +0000 (UTC)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
 by mxout3.routing.net (Postfix) with ESMTP id C5B5B6048C;
 Fri, 30 Jul 2021 13:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
 s=20200217; t=1627651087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PkViEFXPVgM8mzZAi7UeLENFKB2DTHjszsn3u7Q4Bjw=;
 b=QWOfHaGc9aP6MbHjbleIXA+r3CvKttwF/YUremF7qxPrtEpwidg0bKmO2LTBac//+pb3VM
 icgNF2brx5d0gDnF9224jVc2kgsqsQMwG4BXqETRevG6cVN38c2HFEpjXXEpiUVerlc1u6
 QWilu+V5WqsqqrtL06YRVQgVMHnNeFA=
Received: from webmail.hosting.de (unknown [134.0.26.148])
 by mxbox2.masterlogin.de (Postfix) with ESMTPA id 50012100695;
 Fri, 30 Jul 2021 13:18:07 +0000 (UTC)
MIME-Version: 1.0
Date: Fri, 30 Jul 2021 15:18:07 +0200
From: "Frank Wunderlich (linux)" <linux@fw-web.de>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu: check if group is NULL before remove device
In-Reply-To: <YO/hpPpu6Z526+Ia@8bytes.org>
References: <20210715071150.82157-1-linux@fw-web.de>
 <YO/hpPpu6Z526+Ia@8bytes.org>
Message-ID: <d8c1f7326e6427c33c5ea68bd68adced@fw-web.de>
X-Sender: linux@fw-web.de
User-Agent: Roundcube Webmail/1.3.16
X-Mail-ID: e0c0c7cb-d211-4581-81e3-8adad627b420
Cc: iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Frank Wunderlich <frank-w@public-files.de>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Am 2021-07-15 09:20, schrieb Joerg Roedel:
> On Thu, Jul 15, 2021 at 09:11:50AM +0200, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files.de>
>> 
>> if probe is failing, iommu_group may be not initialized,
> 
> Sentences start with capital letters.
> 
> IOMMU patch subjects too, after the 'iommu:' prefix.
> 
>> so freeing it will result in NULL pointer access
> 
> Please describe in more detail how this NULL-ptr dereference is
> triggered.

in my case probe (mtk_iommu_probe_device called from 
__iommu_probe_device) is failing due to fwspec missing and then 
dev_iommu_free/iommu_fwspec_free is called, later 
iommu_group_remove_device with group=NULL

i think i've found problem:

iommu_probe_device:
     group = iommu_group_get(dev);
     if (!group) { //group is checked here for NULL but accessed later
         ret = -ENODEV;
         goto err_release; <<<
     }
err_release:<<<
     iommu_release_device(dev);

------------------------------------------------------------------------------
void iommu_release_device(struct device *dev)
{
...
     iommu_group_remove_device(dev);

------------------------------------------------------------------------------
void iommu_group_remove_device(struct device *dev)
{
     struct iommu_group *group = dev->iommu_group;
     struct group_device *tmp_device, *device = NULL;
...
     dev_info(dev, "Removing from iommu group %d\n", group->id); //crash 
as group is NULL and not checked
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
