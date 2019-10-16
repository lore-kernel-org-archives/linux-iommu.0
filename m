Return-Path: <SRS0=NqTC=YJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65B5ECE599
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 22:59:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8908D207FF
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 22:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wgk6dAjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8908D207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 32A13B5F;
	Wed, 16 Oct 2019 22:59:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BC66DB50
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 22:59:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 50FE288E
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 22:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1571266747;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:mime-version:mime-version:
	content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=NyiMlWJkqAf8MO4pTs8/WbLKzyR9A5LqxtBH32MGUbQ=;
	b=Wgk6dAjEg5C/jE2LxSPqTFrSMyE/48DBnZFcWeWrKve3qLabx3SsxvqIQB+d4x8HxB4Q7p
	RF4bpMnzJr9pDz+Yy9DQzb+dgAS1UhPkTHmQ9dio7eXo3YX1/12Xc0+IU7TKEPG+1k/7iw
	6gOrXjScLUUA/nrhOmjeblt69lZk08g=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
	[209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
	us-mta-273-N9GTSbD6MWGlpmIE_FpEPQ-1; Wed, 16 Oct 2019 18:59:03 -0400
Received: by mail-io1-f71.google.com with SMTP id g8so282426iop.19
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 15:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:subject:message-id:reply-to
	:mail-followup-to:references:mime-version:content-disposition
	:in-reply-to:user-agent;
	bh=izr2IsFI8KdP3bcHd0eKxqMK3CSawZuxmuGffwvF3wM=;
	b=Vw8BOBijM/Pkt3T6gBirD9J0fJrjasfaBm7Nv6WVN6I9p82YBLntMMp7L9vWcn+Can
	knVrQJwT5wk5uFDb4QLVu4UclpbKr25rf6rJ6uDbRIl2GZUmus2/HlCug0qTQ1h+lcWT
	ozgmPst52KYUirHWnBz2Zj6yTQsWYjvCiZ6axsuXvtJrLGCHr6pKSUoMqEzut0rVQpG6
	1LJda1tQtuyYo3tJoui0+nuHaN1fCB9kD33c082obbessgMTTTOAg9H46H4Fbckey9P1
	ByffCO9bjFPYE8TcPi0C5Yn69lcs5lO3Vxegd3ovop9MxxCBT+JHqFf001jNg59wM6GI
	+BBA==
X-Gm-Message-State: APjAAAXiCSx2TxfOTWgjIOl1pOvyAOywF9bHFKe2d0AujG4yah6mslR8
	fDS6zylZjwWRlUhsKkHilasXJkMO7sRHFRe+fXLDPo5berfViFeJI0EmiwgNSIyFNP6yWdKpsRS
	1kAdKrjIb7JcRnaDDz1jp1pPOTZEZpQ==
X-Received: by 2002:a02:7124:: with SMTP id n36mr450930jac.90.1571266743020;
	Wed, 16 Oct 2019 15:59:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyXgcSDWOvFVRU4qEgI4WtmHcPsJHr4aMIDVzx1G2HnyuwCQ56ZEGP2XRwkkjSFyOMu6fRo6A==
X-Received: by 2002:a02:7124:: with SMTP id n36mr450914jac.90.1571266742774;
	Wed, 16 Oct 2019 15:59:02 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
	by smtp.gmail.com with ESMTPSA id t8sm101183ild.7.2019.10.16.15.59.00
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 16 Oct 2019 15:59:01 -0700 (PDT)
Date: Wed, 16 Oct 2019 15:58:59 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Qian Cai <cai@lca.pw>, jroedel@suse.de, don.brace@microsemi.com,
	martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	jejb@linux.ibm.com, esc.storagedev@microsemi.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH -next] iommu/amd: fix a warning in increase_address_space
Message-ID: <20191016225859.j3jq6pt73mn56chn@cantor>
Mail-Followup-To: Qian Cai <cai@lca.pw>, jroedel@suse.de,
	don.brace@microsemi.com, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, jejb@linux.ibm.com,
	esc.storagedev@microsemi.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
References: <1571254542-13998-1-git-send-email-cai@lca.pw>
	<20191016220415.cbam7qk3pxjmw4gi@cantor>
MIME-Version: 1.0
In-Reply-To: <20191016220415.cbam7qk3pxjmw4gi@cantor>
User-Agent: NeoMutt/20180716
X-MC-Unique: N9GTSbD6MWGlpmIE_FpEPQ-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
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

On Wed Oct 16 19, Jerry Snitselaar wrote:
>On Wed Oct 16 19, Qian Cai wrote:
>>
>>BTW, Joerg, this line from the commit "iommu/amd: Remove domain->updated" looks
>>suspicious. Not sure what the purpose of it.
>>
>>*updated = increase_address_space(domain, gfp) || *updated;
>>
>
>Looking at it again I think that isn't an issue really, it would just
>not lose updated being set in a previous loop iteration, but now
>I'm wondering about the loop itself. In the cases where it would return
>false, how does the evaluation of the condition for the while loop
>change?
>

I guess the mode level 6 check is really for other potential callers
increase_address_space, none exist at the moment, and the condition
of the while loop in alloc_pte should fail if the mode level is 6.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
