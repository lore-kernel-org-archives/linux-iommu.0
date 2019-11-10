Return-Path: <SRS0=BeoY=ZC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A83C17442
	for <iommu@archiver.kernel.org>; Sun, 10 Nov 2019 20:37:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386372080F
	for <iommu@archiver.kernel.org>; Sun, 10 Nov 2019 20:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjKrdXSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386372080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E243BA59;
	Sun, 10 Nov 2019 20:37:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B919AA55
	for <iommu@lists.linux-foundation.org>;
	Sun, 10 Nov 2019 20:37:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com
	[209.85.166.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3A0A1FE
	for <iommu@lists.linux-foundation.org>;
	Sun, 10 Nov 2019 20:37:02 +0000 (UTC)
Received: by mail-il1-f193.google.com with SMTP id o18so10115869ils.12
	for <iommu@lists.linux-foundation.org>;
	Sun, 10 Nov 2019 12:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=PYkUdq1QNwEYjmWnKj0EdSuQZBm50tV0WRMLPz5fi40=;
	b=YjKrdXSAahH1StV8EmSM0xqq4aLCOmXxLU+j1f4BFwlEJmyrOlP8RZba67nit3HqzZ
	DM0QOGvUfkHeJ0i1omMyHJ0v9iSEfXl49WzFAq70cWB6KBQF91bZV/aZ7PJDYo5vvjsl
	m8lqsOILU324B9CX+YylLNIqu+CqkNaL2lm4GmxdverQZZagLlK5LldN8LpbxzuwoOjk
	0pPRitP0e2w3MEHCNpLzlYHyIV2jUULL7hRCoXLd6klTDgrgpxBHNxWt5VAJP6m0vOGn
	wVQVH7CDt3gNJvsHaLfqExGe/GjEMeQLmbEy16STAvESl8tCI9lljvE6NN8rMSnHRdeL
	S2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=PYkUdq1QNwEYjmWnKj0EdSuQZBm50tV0WRMLPz5fi40=;
	b=RHBu5Ro9T1SXnS6mBnRpligK0rf/s04fXn21gNljVHKMBrsv/s3wVj4mzCXzxfxqjV
	oq5BT0or2QdIk17DYNX3WnSxoeDoyeHbCRRu83uYG6WVNXhoBViUKyMpZSOrtg3tpxVU
	SMGTY6K64nlncLAoHwoqAFo3JAyiqvCXCJeU7RkEXSFbJRhEyiSkM0v7amxkWH7B33N8
	kSdNQzH6kPbFZgNGQPqAyQhWIVOGqFyNzk7/ZY5kH0100nQ7mu1IYnfCLY7U7O3HzWxp
	/B2xK2aTd4nLTVawlR/F01bQ/WfWpbX6CHvVZKEDXHsirKaSNK8NuDXw4BTxUeuSrxVk
	85Ew==
X-Gm-Message-State: APjAAAVgveq1coQEa6FY9H0DcLFodgSLrryU8rCYYDQqOh7YuPirqBfX
	WHW3mJbGcAsGRtGMC5tMX/ufPoW9bSHMCiLBfwI=
X-Google-Smtp-Source: APXvYqxONBNYETcCcUx22bjTXa1sKNF4MrVTIE2FFq9+pLOdkaD4ocrmdqnJ9MtBZc99i0YC9k5Ha4jPIpBl2Wj89B0=
X-Received: by 2002:a92:d7c2:: with SMTP id g2mr17371311ilq.81.1573418221372; 
	Sun, 10 Nov 2019 12:37:01 -0800 (PST)
MIME-Version: 1.0
References: <20191107205914.10611-1-deepa.kernel@gmail.com>
	<1672a5861c82c2e3c0c54b5311fd413a8eee5e64.camel@infradead.org>
	<8D8B600C3EC1B64FAD4503F0B66C61F23BB95B@SHSMSX103.ccr.corp.intel.com>
	<addba4e401c3bf23b86cf8dff97256282895e29f.camel@infradead.org>
	<8D8B600C3EC1B64FAD4503F0B66C61F23BBA24@SHSMSX103.ccr.corp.intel.com>
	<CABeXuvoiX639HchLbgTHLiXPh=Yr2dJHUp2Yqc6pNJ3As1OJ8A@mail.gmail.com>
	<CABeXuvqMpXbSNasET4-u16Hrj710fe-V706tsFZhOTJoir8Xjw@mail.gmail.com>
In-Reply-To: <CABeXuvqMpXbSNasET4-u16Hrj710fe-V706tsFZhOTJoir8Xjw@mail.gmail.com>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Sun, 10 Nov 2019 12:36:49 -0800
Message-ID: <CABeXuvrYzLoc7YGtmXDJqEovwyERbndN4cC6UaYAw5+qABRr8A@mail.gmail.com>
Subject: Re: [PATCH] intel-iommu: Turn off translations at shutdown
To: "Zeng, Jason" <jason.zeng@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	rminnich@google.com, David Woodhouse <dwmw2@infradead.org>
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

On Sun, Nov 10, 2019 at 10:24 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> On Fri, Nov 8, 2019 at 2:48 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >
> > > > > For VMM live update case, we should be able to detect and bypass
> > > > > the shutdown that Deepa introduced here, so keep IOMMU still operating?
> > > >
> > > > Is that a 'yes' to Deepa's "if someone wants to make it conditional, we
> > > > can do that" ?
> > >
> > > Yes, I think so. Thanks!
> >
> > Are these changes already part of the kernel like avoiding shutdown of
> > the passthrough devices? device_shutdown() doesn't seem to be doing
> > anything selectively as of now.
>
> I've posted the v2 without the conditional for now:
> https://lore.kernel.org/patchwork/patch/1151225/
>
> As a side topic, I'm trying to support https://www.linuxboot.org/. I
> have a couple of more such cleanups coming. The VMM live updates and
> linuxboot seem to have contradicting requirements and they both use
> kexec. So kexec_in_progress doesn't seem like a sufficient indicator
> to distinguish between the two. Do you already have an idea on how to
> distiguish between them? Does a separate sys_reboot() command
> parameter sound ok? Or, we could use the flags in the sys_kexec_load()
> depending on how the live update feature is implemented.

Also, the AMD driver disables iommu at shutdown already. So the live
update feature is already broken on AMD.

-Deepa
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
