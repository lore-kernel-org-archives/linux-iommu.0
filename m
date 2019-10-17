Return-Path: <SRS0=zJQD=YK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E97ECE58E
	for <iommu@archiver.kernel.org>; Thu, 17 Oct 2019 11:36:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A7521848
	for <iommu@archiver.kernel.org>; Thu, 17 Oct 2019 11:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="inLSz4cP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A7521848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 71F341524;
	Thu, 17 Oct 2019 11:36:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E8C1F14C3
	for <iommu@lists.linux-foundation.org>;
	Thu, 17 Oct 2019 11:36:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
	[209.85.222.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 83A228C1
	for <iommu@lists.linux-foundation.org>;
	Thu, 17 Oct 2019 11:36:53 +0000 (UTC)
Received: by mail-qk1-f193.google.com with SMTP id u184so1524144qkd.4
	for <iommu@lists.linux-foundation.org>;
	Thu, 17 Oct 2019 04:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=content-transfer-encoding:from:mime-version:subject:date:message-id
	:references:cc:in-reply-to:to;
	bh=8/Lz6l8sQ6PNj+KFicIECgEvYNy1usZIJng2CZIsbQg=;
	b=inLSz4cPMI+GJ9z0YEfQf9RIV4d9DhKHvhpv9tRsAhG8lBPHCahDt7L4dZdCUDpNT3
	V0qQsIIWtsi1zCvqA2zEvouImw2pz4PKQq7hNViCPYJJovM/WhPMwRFyY2ASg8xwBJ9e
	3W7+KJNGsqtkQD7da4idydHyGxNm4S89TLBE1EO5Nsrb7rxQFLv7OHaNsX/MyjrqvoQf
	sm4KR/GZnvc1LUVfYS7OZDzwz3t4PvX1fBGcOPD7sxVYWgEMvd2t+Q5JPWvhC3dGKSBs
	ZmiLjM0dWcfgsG936+m01CkzNYi/KsWTeJ9XauEjKWmMjpkupFQQrtOUJwu1GXjwYO4O
	E4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:content-transfer-encoding:from:mime-version
	:subject:date:message-id:references:cc:in-reply-to:to;
	bh=8/Lz6l8sQ6PNj+KFicIECgEvYNy1usZIJng2CZIsbQg=;
	b=logV7MQp/C+qr9/NOmq60Vo0OkaZUnpDINeXvc2MeXsJanFnJzk0r7FgneZ1PEq57m
	CcKnzj5RQg1sXSt5GEDa9unZ0eFbKsubPfyZw4vI5boVZ8T7bzvjxAy0SEf9rfy0ryaJ
	oDoD3FlQ31KAx/+TXDEuPthjVkmCiLwz/xjskfqp2LXQDK6/kNwVeliYf6od5+tMgtVH
	ySqOrsAadAPcfvACBIArkhHq9CW98ahai103ObdIwU/IWqT02PFnT0GJt/HcH8MwgQR9
	mzwX+w6OJXNgTL9t8kAmdkBmVkEqV7W3rH+ZO6bCBYKsEj8PsLrA5wPQQBFop4qf2ldD
	L9hw==
X-Gm-Message-State: APjAAAVoYODKlijHAbE5ZoMS/ykcbZK+gulzQu548YXyrKEZLT+MkJnS
	D/06nbR5gV0ZPow23X6a+2Claw==
X-Google-Smtp-Source: APXvYqxdX0AeuN/dq2A2s87VdUR+xtxVcyeC34SKMarZg2FnGvyBY3fPdW9PrLgHFt8PN82r/JKQvw==
X-Received: by 2002:a37:68a:: with SMTP id 132mr2773971qkg.359.1571312212534; 
	Thu, 17 Oct 2019 04:36:52 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net.
	[71.184.117.43])
	by smtp.gmail.com with ESMTPSA id c6sm1631979qtc.83.2019.10.17.04.36.51
	(version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
	Thu, 17 Oct 2019 04:36:51 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] iommu/amd: fix a warning in increase_address_space
Date: Thu, 17 Oct 2019 07:36:51 -0400
Message-Id: <577A2A6B-3012-4CDE-BE57-3E0D628572CB@lca.pw>
References: <20191016225859.j3jq6pt73mn56chn@cantor>
In-Reply-To: <20191016225859.j3jq6pt73mn56chn@cantor>
To: Jerry Snitselaar <jsnitsel@redhat.com>
X-Mailer: iPhone Mail (17A878)
Cc: don.brace@microsemi.com, jroedel@suse.de, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, jejb@linux.ibm.com,
	esc.storagedev@microsemi.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
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



> On Oct 16, 2019, at 6:59 PM, Jerry Snitselaar <jsnitsel@redhat.com> wrote:
> 
> I guess the mode level 6 check is really for other potential callers
> increase_address_space, none exist at the moment, and the condition
> of the while loop in alloc_pte should fail if the mode level is 6.

Because there is no locking around iommu_map_page(), if there are several concurrent callers of it for the same domain, could it be that it silently corrupt data due to invalid access?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
