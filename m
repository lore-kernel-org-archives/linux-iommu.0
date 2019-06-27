Return-Path: <SRS0=izKu=U2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593F6C48BD3
	for <iommu@archiver.kernel.org>; Thu, 27 Jun 2019 00:27:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E3EA216C8
	for <iommu@archiver.kernel.org>; Thu, 27 Jun 2019 00:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F94wlCr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3EA216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E5E0FDC3;
	Thu, 27 Jun 2019 00:27:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4CCF2AAE
	for <iommu@lists.linux-foundation.org>;
	Thu, 27 Jun 2019 00:27:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 09D2E3D0
	for <iommu@lists.linux-foundation.org>;
	Thu, 27 Jun 2019 00:27:23 +0000 (UTC)
Received: from localhost (unknown [107.242.116.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 08FA52083B;
	Thu, 27 Jun 2019 00:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561595243;
	bh=uhaynaqhaiNRiWR+el+3VKsZktd5cOez22t0B6otRO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F94wlCr+MI3B4J7cVI2XFVJ/sx5MDgOPP4LIJz6BO5UuH+ajbt11nIX8W7jzT5Q5d
	oTqk9gvHg5nlNaRz6QWkAUSdQfw9z7AeHryTNlCwBlE0Exfkcok6ylteiquU6Xe4Md
	puf0IsZ6J1npFbVkTAFMyYdxHXQwCvVbLyk4x8r8=
Date: Wed, 26 Jun 2019 20:27:20 -0400
From: Sasha Levin <sashal@kernel.org>
To: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH AUTOSEL 5.1 09/51] iommu/vt-d: Fix lock inversion between
	iommu->lock and device_domain_lock
Message-ID: <20190627002720.GQ7898@sasha-vm>
References: <20190626034117.23247-1-sashal@kernel.org>
	<20190626034117.23247-9-sashal@kernel.org>
	<20190626065606.GT8151@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190626065606.GT8151@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, Dave Jiang <dave.jiang@intel.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

On Wed, Jun 26, 2019 at 08:56:06AM +0200, Joerg Roedel wrote:
>Hi Sasha,
>
>On Tue, Jun 25, 2019 at 11:40:25PM -0400, Sasha Levin wrote:
>> From: Dave Jiang <dave.jiang@intel.com>
>>
>> [ Upstream commit 7560cc3ca7d9d11555f80c830544e463fcdb28b8 ]
>
>This commit was reverted upstream, please drop it from your stable
>queue. It caused new lockdep issues.

I've dropped it, thank you.

--
Thanks,
Sasha
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
