Return-Path: <SRS0=+ySY=UK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E58C4321A
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 14:00:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C99C206BB
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 14:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bhgTz0iZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C99C206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 46A5DD67;
	Tue, 11 Jun 2019 14:00:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C372FC3A
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 14:00:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
	[209.85.160.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 02D866D6
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 14:00:07 +0000 (UTC)
Received: by mail-qt1-f193.google.com with SMTP id x2so13718579qtr.0
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 07:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=iH+zv2NyAQjL/cetbGgHsTzopn+UouK4esOdVcCu/XI=;
	b=bhgTz0iZHBzC141cQuSxSqaQ6tDQrIVqrdGGE0dsBQadX/i+4Srh9EvKSjvHWfQ96D
	y2/cwNUfbWYskuiT226QmbdLGzCBH8hWz9FWoA4qjTsZTIh79U8wHlWpwNLnNQ+8JvH4
	zF4Uzn/c5bbpMhM/SmrCJSY0O+LNAhxKJJW/VLPUMF9Lqhzmc+SGBK3bs8/gKSezBo7D
	LEgR6ItfMPm9Bhlj+vAqpHPpKifwv5kI1a1Jb8xOOt/cLRvUH6CbcGDZuCZwcmca9f5X
	+Fi4AbP1s9Hf4l4QzWm9wqogQWYEIKC8tAw5SxUcMoFLWmIgXfp0wg2aRDcoXfX6HsSH
	drcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=iH+zv2NyAQjL/cetbGgHsTzopn+UouK4esOdVcCu/XI=;
	b=KR9vzMuIu4u3Se3VB5DRAIcqQJHg4akY56a62eJVEHtY4DFKgL4JrEjNbGz3EGAjtG
	f4OZRq8o8t+sA/2A5kGriSrSDgem8HLKkETBK3+399R3BFL6KtSE1Ebn+zJN4l5bD53t
	ORmqN2I2Hyq7NrB07G5yGB6sMvnr15T151ZewJeRVVY8am/Vywa8I0FHlPYAmZg3fS7l
	YxqUnA1mVG9s+HvbBVvLKMW7iZEhKdDSmCZBR1A7by1Y8AoaFI4X37AOfpjTry1eYAjL
	kubH3U3995s1VznSeOVESswUevCCkJ3xuFUdfNmOa9On3T0CtqftOv1dMh3MgjcMSFqV
	WD4w==
X-Gm-Message-State: APjAAAWj0EBgdmN25sjo2LQjL+Q8mmtmBIW4SIOCz355fRGnZvVGHsO8
	Bkvml5b1c/0Gjm/7RFU18rSw+Q==
X-Google-Smtp-Source: APXvYqwvcMDBx+2FFUxbbsHqiUbAKE+XOonBFHNUuVkdEbObgeEeNT+erbNtoXX9y+IO9kDx1s/nVQ==
X-Received: by 2002:a0c:b084:: with SMTP id o4mr35367656qvc.227.1560261607009; 
	Tue, 11 Jun 2019 07:00:07 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net.
	[71.184.117.43]) by smtp.gmail.com with ESMTPSA id
	g53sm3000938qtk.65.2019.06.11.07.00.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 11 Jun 2019 07:00:06 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: "iommu/vt-d: Delegate DMA domain to generic iommu" series breaks
	megaraid_sas
From: Qian Cai <cai@lca.pw>
In-Reply-To: <2ff8404d-7103-a96d-2749-ac707ce74563@linux.intel.com>
Date: Tue, 11 Jun 2019 10:00:02 -0400
Message-Id: <AB191BD9-239D-4962-AED3-52AABED5C7C0@lca.pw>
References: <1559941717.6132.63.camel@lca.pw>
	<1e4f0642-e4e1-7602-3f50-37edc84ced50@linux.intel.com>
	<1560174264.6132.65.camel@lca.pw> <1560178459.6132.66.camel@lca.pw>
	<2ff8404d-7103-a96d-2749-ac707ce74563@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Cc: Joerg Roedel <jroedel@suse.de>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>, iommu@lists.linux-foundation.org
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



> On Jun 10, 2019, at 9:41 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
> Ah, good catch!
> 
> The device failed to be attached by a DMA domain. Can you please try the
> attached fix patch?

It works fine.

> 
> [  101.885468] pci 0000:06:00.0: DMAR: Device is ineligible for IOMMU
> domain attach due to platform RMRR requirement.  Contact your platform
> vendor.
> [  101.900801] pci 0000:06:00.0: Failed to add to iommu group 23: -1
> 
> Best regards,
> Baolu
> 
> On 6/10/19 10:54 PM, Qian Cai wrote:
>> On Mon, 2019-06-10 at 09:44 -0400, Qian Cai wrote:
>>> On Sun, 2019-06-09 at 10:43 +0800, Lu Baolu wrote:
>>>> Hi Qian,
>>>> 
>>>> I just posted some fix patches. I cc'ed them in your email inbox as
>>>> well. Can you please check whether they happen to fix your issue?
>>>> If not, do you mind posting more debug messages?
>>> 
>>> Unfortunately, it does not work. Here is the dmesg.
>>> 
>>> https://raw.githubusercontent.com/cailca/tmp/master/dmesg?token=AMC35QKPIZBYUM
>>> FUQKLW4ZC47ZPIK
>> This one should be good to view.
>> https://cailca.github.io/files/dmesg.txt
> <0001-iommu-vt-d-Allow-DMA-domain-attaching-to-rmrr-locked.patch>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
