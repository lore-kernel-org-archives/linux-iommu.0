Return-Path: <SRS0=l9dJ=DG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BFEC47420
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 23:48:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 258902158C
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 23:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="egTjnuud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258902158C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9356384B36;
	Tue, 29 Sep 2020 23:48:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vhfXMY-xYWZh; Tue, 29 Sep 2020 23:48:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D662D81F3F;
	Tue, 29 Sep 2020 23:48:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B55B9C016F;
	Tue, 29 Sep 2020 23:48:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DD69C0051
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 23:48:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 822B0871B0
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 23:48:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sSW0pfktlgmZ for <iommu@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 23:48:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com
 [136.143.188.51])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 83EA9871AD
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 23:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1601423276; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IuHFzA2EPmZVTQAmNMF4hK23usbjcpiZaONQfHKiFJ6We32LP7rL033dQE4heQC0h6QXFtBvqir0Upv47NhIAu+ufAkQ2QBYZDIg1M2Sp7fGYlQ02jlmMx8VX1gRQRn1GtHzRTr+aVdGufec0bXknVYs7vydMvhY+DU2T6xviCY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601423276;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=6ixniHgEplVIhcPaYdBMZkE4jAKURq3FUls7D6j7mik=; 
 b=PqpssLwkJvkfIJGONsDphYoIj6Np0wmDe8kG4J27N2bha/+JlYKOQYKdYlzsOQEE0422PfOTXDyfWF2HT1bLgNO3P0Jch56EFEoV2EDN6BWzqRmQyXR8huJvTLCk6jb/NFBsVbIdth7eaSa93B8y57Vp9kPQzwq0UCtYST1FLeI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=apertussolutions.com;
 spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
 dmarc=pass header.from=<dpsmith@apertussolutions.com>
 header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1601423276; 
 s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
 h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=6ixniHgEplVIhcPaYdBMZkE4jAKURq3FUls7D6j7mik=;
 b=egTjnuudxteogSv2KKbJdqWcZX7Tc8LBFmsOCMCYEPoRRq64hH8AmPNdOF7PzsY0
 37NjbcDY0rtR62HG2JUxPuP1DNEeCm0dn+lvAOwfL02NyLDCUGcgPm7jgTIk1wGf+Db
 TJUpntq7OIE9Lv7G99tU1TBWc8asjAL7tzIOkGY8=
Received: from [10.10.1.24] (c-73-129-147-140.hsd1.md.comcast.net
 [73.129.147.140]) by mx.zohomail.com
 with SMTPS id 1601423275480196.65040696695542;
 Tue, 29 Sep 2020 16:47:55 -0700 (PDT)
Subject: Re: [PATCH 05/13] x86: Add early TPM1.2/TPM2.0 interface support for
 Secure Launch
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 Ross Philipson <ross.philipson@oracle.com>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <1600959521-24158-6-git-send-email-ross.philipson@oracle.com>
 <20200925054313.GB165011@linux.intel.com>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Message-ID: <bf1d8df9-ec79-2cc6-534f-ce1f0a58f123@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; prefer-encrypt=mutual; keydata=
 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
Date: Tue, 29 Sep 2020 19:47:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200925054313.GB165011@linux.intel.com>
Content-Language: en-US
X-ZohoMailClient: External
Cc: linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 luto@amacapital.net, iommu@lists.linux-foundation.org, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, linux-integrity@vger.kernel.org,
 trenchboot-devel@googlegroups.com, tglx@linutronix.de
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 9/25/20 1:43 AM, Jarkko Sakkinen wrote:
> On Thu, Sep 24, 2020 at 10:58:33AM -0400, Ross Philipson wrote:
>> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>>
>> This commit introduces an abstraction for TPM1.2 and TPM2.0 devices
>> above the TPM hardware interface.
>>
>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> 
> This is way, way too PoC. I wonder why there is no RFC tag.

An RFC was sent back in March and we incorporated the feedback we
received at that time.

> Please also read section 2 of
> 
> https://www.kernel.org/doc/html/v5.8/process/submitting-patches.html
> 
> You should leverage existing TPM code in a way or another. Refine it so
> that it scales for your purpose and then compile it into your thing
> (just include the necesary C-files with relative paths).

We explained during the RFC phase that we took a fair bit of time and a
very hard look to see if we could #include sections out the TPM driver
but as it is today none of the TPM driver's c files can be included
outside of the mainline kernel. If you look at the early boot stub for
the compressed kernel you will see that we are interacting with the TPM
as the first thing upon leaving the assembly world and entering C. Since
we weren't going to be able to get the mainline TPM driver plucked down,
we could either 1.) borrow an implementation from a colleague that
provides the minimum command strings hard coded in C macros to send
measurements to the TPM or 2.) reuse the TPM implementation we wrote for
TrenchBoot's AMD Secure Loader (LZ). The former is not well supported
and the latter will be getting maintenance under TB. While this is not
preferred, we had to weigh this versus trying to convince you and the
other TPM driver maintainers on a significant refactoring of the TPM
driver. It was elected for the reuse of a clean implementation that can
be replaced later if/when the TPM driver was refactored. When we
explained this during the RFC and it was not rejected, therefore we
carried it forward into this submission.


> How it is now is never going to fly.

We would gladly work with you and the other TPM maintainers on a
refactoring of the TPM driver to separate core logic into standalone
files that both the driver and the compressed kernel can share.

> /Jarkko
> 


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
