Return-Path: <SRS0=Xx/3=YV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCF0CA9EC2
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 16:20:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405CB21721
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 16:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+CcdotX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405CB21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 14202B7A;
	Mon, 28 Oct 2019 16:20:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D3E1AAD0
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 16:20:48 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A2E81876
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 16:20:48 +0000 (UTC)
Received: from localhost (unknown [91.217.168.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id D870620873;
	Mon, 28 Oct 2019 16:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572279648;
	bh=kR8ZRzVktZsrVSrs2I+9RAcAnHJT9+FqtAQh0LUTVHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h+CcdotX99a+WwOjrTnnkEHvtlomQufJsJ0DhoVWalWzZ9EgmZph8UOPmGTXNDvYK
	ZSmgR821TnE6kwIqS7aWWVKf9YIkAO5MgmLdK3xPhMnlBcgHyHQZfSkjW0VBnpg7Xy
	LAgAA83grRD/5N/R4Pb+gKRQ1ia+IxtJvNlqDymw=
Date: Mon, 28 Oct 2019 12:20:45 -0400
From: Sasha Levin <sashal@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] drivers: iommu: hyperv: Make HYPERV_IOMMU only available
	on x86
Message-ID: <20191028162045.GG1554@sasha-vm>
References: <20191017005711.2013647-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191017005711.2013647-1-boqun.feng@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-hyperv@vger.kernel.org, Lan Tianyu <Tianyu.Lan@microsoft.com>,
	linux-kernel@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, Oct 17, 2019 at 08:57:03AM +0800, Boqun Feng wrote:
>Currently hyperv-iommu is implemented in a x86 specific way, for
>example, apic is used. So make the HYPERV_IOMMU Kconfig depend on X86
>as a preparation for enabling HyperV on architecture other than x86.
>
>Cc: Lan Tianyu <Tianyu.Lan@microsoft.com>
>Cc: Michael Kelley <mikelley@microsoft.com>
>Cc: linux-hyperv@vger.kernel.org
>Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>

Queued up for hyperv-fixes, thanks!

-- 
Thanks,
Sasha
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
