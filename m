Return-Path: <SRS0=xPYy=XP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F56C49ED7
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 05:50:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6742720882
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 05:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="PJwrRasi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6742720882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 395B5B62;
	Fri, 20 Sep 2019 05:50:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 52423B5F
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 05:49:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5183C711
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 05:49:58 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id l3so5394250wru.7
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 22:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=monstr-eu.20150623.gappssmtp.com; s=20150623;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=uRLxhAVojptV7hgufrR07c/bFSb5W8HdGjW/XXrGNmU=;
	b=PJwrRasi1kvi4TmmQYpADULUr/CFngg3AmxStXvpOMMd9XLvfW6gLqmv9AnclVnZdR
	SuQ1zMH/YhetXtvCG729brMaADmj4KIkDQV9Ni60QWyN6rZLQ4t9xKUIJBF6FmmB3drE
	GpLZifw7YgMCRV0FXOBLZJdclkPTEfbN3vYABril5hbKhU1eT8u0Pr95hcxkjxFFN2OF
	qJUb6E7w4OdWUifrRkp3CUX0mHTukoji4GQDtnghQsabqlL2KFy6v+gNSJ1CfGG6afOE
	woxcInQwT3lg7vY7kYqHMRtm5EO2osE7C0HtTuLX+yoz33vClM6KLedQqiG0iEbqKMfM
	IPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=uRLxhAVojptV7hgufrR07c/bFSb5W8HdGjW/XXrGNmU=;
	b=APbeaekqvWzqfDz+AAH1nVUeK2V7Rx+722CH51IfyAYFXC4aNIMd/8O9C8+HbU0YSb
	+PxWlyYbjhe2LiqtuTGPrNNCS0flBKbinfU5AU+P0NHJPdoEEYuqyANV2bTbYXDsx2d2
	Un5HtAR/YNuC7uDQ7Ac9DXrnjDGxbk52kdxHV9XPmEjCvkdrX329N5STVcHSb35URL64
	EWE3K7mup4qHy7tkySMF42MOZJz1AKmWfrB160WBYui7lWBUZfHOi9k+NafyNCiJVqRn
	M8sKNm///cRsEy08aiJscy3hyXlmjCmAz80w+Nh5sSDR111ZC082f/04pV+sdNaNfM15
	6pYw==
X-Gm-Message-State: APjAAAU7OwYaC/UfS5RX5vilAXzAuiyXyd9FbCjIUtLPWGI5BVNnDAPt
	eOcqUs/vPeoT0ngcAqMIKyEq8Q==
X-Google-Smtp-Source: APXvYqw84BAy83Ziqr1cUVL1uIreNc5GnWBmxBOqLpZzveJLBRsyNiy8z1SV97YD/7CEFzhiHlV8PA==
X-Received: by 2002:a5d:49cb:: with SMTP id t11mr2692912wrs.158.1568958596630; 
	Thu, 19 Sep 2019 22:49:56 -0700 (PDT)
Received: from [74.125.133.108] ([149.199.62.129])
	by smtp.gmail.com with ESMTPSA id i14sm903253wra.78.2019.09.19.22.49.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 19 Sep 2019 22:49:55 -0700 (PDT)
Subject: Re: [GIT PULL] dma-mapping updates for 5.4
To: Michael Ellerman <michael@ellerman.id.au>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>
References: <20190918152748.GA21241@infradead.org>
	<CAHk-=wjXF63BKNJH=GtnnoJmXZHEnRwjgeu4foJQvFYYBm9HHA@mail.gmail.com>
	<D422FEED-06F6-44BE-955F-90318693FD96@ellerman.id.au>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <5cc09e92-96ce-dc40-4bc1-f10a4cad6f7d@monstr.eu>
Date: Fri, 20 Sep 2019 07:49:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <D422FEED-06F6-44BE-955F-90318693FD96@ellerman.id.au>
Content-Language: en-US
Cc: xen-devel@lists.xenproject.org, iommu <iommu@lists.linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On 20. 09. 19 1:17, Michael Ellerman wrote:
> 
> 
> On 20 September 2019 6:33:50 am AEST, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> On Wed, Sep 18, 2019 at 8:27 AM Christoph Hellwig <hch@infradead.org>
>> wrote:
>>>
>>> please pull the dma-mapping updates for 5.4.
>>
>> Pulled.
>>
>>> In addition to the usual Kconfig conflics where you just want to keep
>>> both edits there are a few more interesting merge issues this time:
>>>
>>>  - most importanly powerpc and microblaze add new callers of
>>>    dma_atomic_pool_init, while this tree marks the function static
>>>    and calls it from a common postcore_initcall().  The trivial
>>>    functions added in powerpc and microblaze adding the calls
>>>    need to be removed for the code to compile.  This will not show up
>>>    as a merge conflict and needs to be dealt with manually!
>>
>> So I haven't gotten the powerpc or microblaze pull requests yet, so
>> I'm not able to fix that part up yet.
>>
>> Intead, I'm cc'ing Michael Ellerman and Michal Simek to ask them to
>> remind me when they _do_ send those pull requests, since otherwise I
>> may well forget and miss it. Without an actual data conflict, and
>> since this won't show up in my build tests either, it would be very
>> easy for me to forget.
>>
>> Micha[e]l, can you both please make sure to remind me?
> 
> Yeah I was aware of it, and will make sure to remind you in my pull request.

Same here.

Michal


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
