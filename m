Return-Path: <SRS0=V6zV=XV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80B7C432C2
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 00:25:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E78821A4A
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 00:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mxy1UE6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E78821A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 67BD2EB8;
	Thu, 26 Sep 2019 00:25:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7E03ACD5
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 00:25:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com
	(us-smtp-delivery-1.mimecast.com [205.139.110.120])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id E7FBF108
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 00:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1569457522;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=M9LJpP7JWmBUGgAl1VoixtxnvfidwyCHWS9Xy0f2b+U=;
	b=Mxy1UE6DEI+6Ta0QpST9OBOH6L6VGhrr5dxbO6RAlFz0EfHY0Kirb58jgo6RpOx1Kg1pkn
	YgiaV2J8IBAJTUZCvvuG8EVHXmeOiSXoXTkkTscTe0IoA8iaLDKgEt/guskcBXvCVOXfG9
	89wioPHc6gm0I4Bw7aWi2rvJsGCE0kI=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
	[209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
	us-mta-240-GAG56d12Ovebua03YCfokg-1; Wed, 25 Sep 2019 20:25:19 -0400
Received: by mail-io1-f72.google.com with SMTP id o11so1081515iop.12
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 17:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=QFrp1JmRS1j7kXZhEqRWc1jjvzTVA7ZCrrUMcuvofE4=;
	b=hb4C05TI6zabT37fNu0J/Ujwa8DW2Ty5XCOAocFFHy+SltLuaO9qdUcwjQ99bRT0y/
	clRKqNNb/nmeL9obrupK7KSG4Z7tbUdJGafeU4euuQtq0cGliCV1JpXbTHyuPMJ4GUju
	nI3qhjPsw6yStceIkqSZRm/x5gZyceTbEUDTEQROG5J1nAosk8mztso5pHuE6hUvAlHs
	G1GO5BRVGWV4tP8z+US0iMpfE0Aw3aP6YAyfZfwEf1bGbqPYR/moz11FQ1VwZIvi38Rz
	LiHgTwe1iY8ga8yjkDkUEvwCKXyAI/QObFd9Iu1Is4u9PhWBDhEaYnSqQv/HJDi64s0W
	fX6A==
X-Gm-Message-State: APjAAAV9XwC8KpUh5NxDmTShmHLtZLHPja6gN+mytZT1dmJQx57o6nbX
	3+COy0OGA4mdWzpnMCpuIysNnJASL2n28p5i2irR2QnWBuxPVnXfaejVYd49ObV8MYoBrdZ1VeE
	97bzu5u8f9/2SE6QNOO33i61I97sLww==
X-Received: by 2002:a6b:6d0c:: with SMTP id a12mr832856iod.122.1569457518296; 
	Wed, 25 Sep 2019 17:25:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxqMuNlihbsmAHPcLEdF6dJWB4d07ToHvASQNxsSUCXCR2Y7JBJ9kceZfgq/OAESCuP64kIqw==
X-Received: by 2002:a6b:6d0c:: with SMTP id a12mr832836iod.122.1569457518029; 
	Wed, 25 Sep 2019 17:25:18 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
	by smtp.gmail.com with ESMTPSA id s13sm185605iom.16.2019.09.25.17.25.16
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 25 Sep 2019 17:25:17 -0700 (PDT)
Date: Wed, 25 Sep 2019 17:25:15 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/6] iommu/amd: Locking Fixes
Message-ID: <20190926002515.3xjm3fb6z42dfhar@cantor>
References: <20190925132300.3038-1-joro@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20190925132300.3038-1-joro@8bytes.org>
User-Agent: NeoMutt/20180716
X-MC-Unique: GAG56d12Ovebua03YCfokg-1
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
>Hi,
>
>here are a couple of fixes for the amd iommu driver to fix a
>few locking issues around protection-domains. Main problem
>was that some traversals of ->dev_list were not locked in
>any form, causing potential race conditions.
>
>But there are more issues fixed here, for example the racy
>access to protection_domain->updated and races in the
>attach/detach_device code paths.
>
>Changes are boot-tested with lockdep enabled, looked all
>good so far.
>
>Please review.
>
>Thanks,
>
>	Joerg
>
>Joerg Roedel (6):
>  iommu/amd: Remove domain->updated
>  iommu/amd: Remove amd_iommu_devtable_lock
>  iommu/amd: Take domain->lock for complete attach/detach path
>  iommu/amd: Check for busy devices earlier in attach_device()
>  iommu/amd: Lock dev_data in attach/detach code paths
>  iommu/amd: Lock code paths traversing protection_domain->dev_list
>
> drivers/iommu/amd_iommu.c       | 166 ++++++++++++++++----------------
> drivers/iommu/amd_iommu_types.h |   4 +-
> 2 files changed, 85 insertions(+), 85 deletions(-)
>
>-- 
>2.17.1
>
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu

Hi Joerg,

What branch is this on top of in your repo?

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
