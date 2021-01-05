Return-Path: <SRS0=smho=GI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56353C433DB
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 03:43:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E36D12256F
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 03:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36D12256F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmx.at
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 863958689B;
	Tue,  5 Jan 2021 03:43:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6cqQVn1UQ9DB; Tue,  5 Jan 2021 03:43:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9ABE386833;
	Tue,  5 Jan 2021 03:43:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C665C088B;
	Tue,  5 Jan 2021 03:43:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B200C013A
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 02:27:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4E4F685550
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 02:27:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m2lewQ0Ecn5V for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 02:27:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9703D8554A
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 02:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1609813479;
 bh=KN/kuhbQ/Zqk3LPxC3QeQRjQrGG93v3t7qa9S71Qli4=;
 h=X-UI-Sender-Class:From:Subject:To:Cc:References:Date:In-Reply-To;
 b=dUNg7VQGiVHrFrCRH/ShQ2YsldfY6afbGIiQ8tdwFNEDON9WZCFPNQ/cmxN38z289
 h8qeaDj1AvMv84APdiuLBKXJ7k1267lw5ELojJvuZC6E84937uh9J7S5Nzkw+9+So2
 mQ/i13HwwGdBTAKoKC34vy0qc3iVCnc+FJtjj9Vg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.36] ([85.127.169.10]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MyKDe-1k4VsB0DNM-00yiOX; Tue, 05
 Jan 2021 03:24:39 +0100
From: Johnathan Smithinovic <johnathan.smithinovic@gmx.at>
Subject: Re: [EXTERNAL] PROBLEM: commit f36a74b9345a leads to not booting
 system with AMD 2990WX
To: David Woodhouse <dwmw2@infradead.org>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de
References: <ed4be9b4-24ac-7128-c522-7ef359e8185d@gmx.at>
 <8cfbd243321d91bad760117cc49f1770a7bd819c.camel@infradead.org>
Message-ID: <b03b07db-2952-6e33-e9b7-93d674d024fc@gmx.at>
Date: Tue, 5 Jan 2021 03:24:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8cfbd243321d91bad760117cc49f1770a7bd819c.camel@infradead.org>
Content-Language: en-US
X-Provags-ID: V03:K1:zuHmFm6Yjv5A7N8hRuT/T2zBtifYln9WK2TSvEj6Wdz9+zIHJih
 JOEtZwSrhosjNKFtR3JBbBXQ+thv1vcnru0gEFLr0UDNMLhyfs66yhm+6+xsUxdhh5tCQzH
 jRuhIQwCiBLiT0s+z85ogVD/0gbVPnT1vz7c8wBeuyRejvc4obKxP7q+4KfYFDycm9hYCkw
 u6LaMaRV1FzlSbC+0MhxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:enKILr0t1Y8=:V5lm5Iwp8Hv+M67WtS3eZG
 6VpDTWiuu8X1UFDk6T4T34YZ3aRH62EM0yPYP5BmGkDLbZdZF3Oh2eeS3aGzMLKI9j9H6W2on
 7J3quRUEip9I9pYWEgc2LYvNvbMyLn+VEx/jGvJfWO5HpJv1g5M2aiUbEnCA0NjwHNRW2UyAM
 HaNNkMZB3TifNnKL6GqPpkSEoA07XMdB64IzzPsQkcoMOd+ZsuEuE4pp21jFvJuevRSylh5nx
 z7uSHgntTXfx61PNARrsZX4LIoGZolrNYvI9nttxZk9FakFpSlTJkC+5X3UJ6tZzLGLCz3H3Y
 +bSLi27dnaVCo4S8KCHSqf4MPrpN+MZnzGyJ9+Oh7cr7FIWTPrzgUjy3T9EEFCLUr1bRUftnN
 qVf+Hmfy9M1MNrDVfKEoyHklXkr8QR3RqBvgEHW+DPm02zVl5k8k4eKfGBJD6QaUHUVPCLvtT
 rghh1Kat7G0Yw8p1Cv0DmIqzF/1EXoN5xXRhLtbODo7FzovcXnN0YpS2ars1p4+tttGjymJmr
 ev6XHWjxDeGGzArvZ4mkL1Hv6uqoSswmF6rU2ctPbWSm7VoKgYMgL2qtJAwZOHUBfvuyFmZBE
 cKOo8ePCcIH1DL6do+QWS26CeTQLCK6nKEbFM3svymeNlWkAp25Xzi8FSMRLLh6oqcX8ZDWxk
 KQ0SIYyOrSfdHd2VVrJ7JF4Vrq+N/MBd0a/gcLDRjPd4hrXguw7Jkjzh7QISTv7A4f3ZwbX5n
 BnJ/S+zm6yExuow6/r0w9E5qx+IV6sb+m+Ai1nxZGynv5uMfEbes+DcqQ2iRVSRltFIoxqfXT
 hmaBcNveX9wViAQ4TRoK9KteklbOnrcaJNSUBsyMAqTGtEy3X3gzEubZw2n2SpawT3oZ4e9xq
 8hj0gscfXURA6icZxBIoDkTAHgtnzuMO4dDahHSu4=
X-Mailman-Approved-At: Tue, 05 Jan 2021 03:43:12 +0000
Cc: iommu <iommu@lists.linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
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

On 05/01/2021 01:19, David Woodhouse wrote:
> On Tue, 2021-01-05 at 00:05 +0100, Johnathan Smithinovic wrote:
>> commit f36a74b9345a leads to not booting system with AMD 2990WX
>>
>>
>
> No problem, that was enough to reproduce it in qemu just by simulating
> the same BIOS bug which causes it to *start* enabling, then abort, the
> IRQ remapping. Thanks for the report.
>
> Does this fix it?
>

Yes, the kernel now starts as usual, thanks a lot!

Kind regards
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
