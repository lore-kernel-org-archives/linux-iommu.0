Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9153C43334
	for <iommu@archiver.kernel.org>; Mon,  4 Jul 2022 12:18:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5A51540621;
	Mon,  4 Jul 2022 12:18:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A51540621
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ZTIl9gWmI0w; Mon,  4 Jul 2022 12:18:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 27334405FC;
	Mon,  4 Jul 2022 12:18:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 27334405FC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06438C0088;
	Mon,  4 Jul 2022 12:18:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFBDAC002D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 11:22:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B8654404CF
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 11:22:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B8654404CF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yOr1m_5Ib-nY for <iommu@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 11:22:51 +0000 (UTC)
X-Greylist: delayed 00:07:20 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 805ED4048C
Received: from p3plsmtpa09-03.prod.phx3.secureserver.net
 (p3plsmtpa09-03.prod.phx3.secureserver.net [173.201.193.232])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 805ED4048C
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 11:22:51 +0000 (UTC)
Received: from localhost ([82.17.115.212]) by :SMTPAUTH: with ESMTPA
 id 8K37oHcGkhLDC8K38oUuWd; Mon, 04 Jul 2022 04:15:31 -0700
X-CMAE-Analysis: v=2.4 cv=LfT5VhTi c=1 sm=1 tr=0 ts=62c2cbd3
 a=9gipVNR6X1CoIeAWHwLoWw==:117 a=9gipVNR6X1CoIeAWHwLoWw==:17
 a=IkcTkHD0fZMA:10 a=GPr1rYa5ujshtZzWUQMA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: atomlin@atomlin.com
Date: Mon, 4 Jul 2022 12:15:29 +0100
From: Aaron Tomlin <atomlin@atomlin.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH 3/3] iommu/vt-d: Show region type in
 arch_rmrr_sanity_check()
Message-ID: <20220704111529.6pdlueeu2beo64ha@ava.usersys.com>
References: <20220611204859.234975-1-atomlin@redhat.com>
 <20220611204859.234975-3-atomlin@redhat.com>
 <99632b76-3039-34a5-7615-b25e716e2621@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <99632b76-3039-34a5-7615-b25e716e2621@arm.com>
X-CMAE-Envelope: MS4xfKPF35BvRczXniDFtllcvlL8GhpE6MwRfhiS3R7g0tcxEjsnemJKc93ZWS+yS/omPfyX3CX2HKI+uDxSceFX+Nymms5bGNwU1w6647Ll8b6U4mN+wAt5
 4C4D+z8FELgriEIm0J8Df1u8+3sw8RwqjLMbn7thchaJjGza86QkjqnGbualmIbbXquClhk0t0nHPscnfQOqQVksv7v9Ti4RfBMAc+1xpu4HedaeIjt3o4vO
 IfjTwebIVCsWeKWM4H5WWOWrDlMoiZ/JeVCvH8IUiIvtATkOZ6HOLvtdYxljGjwpmr91xARF0V2Uz/Sgemv4lGQkX+6nO8OiDu/gNuiN6CNfVJC4WXXVcTe0
 cvcr555yOPnn/Ny4V65OksAFEuodgPIEm0d23BL5RFzwLezBbT9KYbpSGQCwdQNOfglAFCf8AZqv4wsStB0oI2ZDTmWRsYBhEqqOT7txveTerZ/bU2+TE133
 leWa1SUfK8twe3NM7u5zEJoiRFHo5RLytQYAX9mVbm86ibl7psl+88ZmKsnA74mMPyChHM0+nkAKEIs55UOj8emQPKFnHI4Bi1yMmg==
X-Mailman-Approved-At: Mon, 04 Jul 2022 12:18:20 +0000
Cc: hpa@zytor.com, dwmw2@infradead.org, dave.hansen@linux.intel.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, Aaron Tomlin <atomlin@redhat.com>,
 tglx@linutronix.de, will@kernel.org
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

On Mon 2022-07-04 11:39 +0100, Robin Murphy wrote:
> On 2022-06-11 21:48, Aaron Tomlin wrote:
> > This patch will attempt to describe the region type in the event
> > that a given RMRR entry is not within a reserved region.
> 
> Hmm, is this useful information for the user? You'd hope the firmware vendor
> knows the memory map already, but either way, is it particularly likely that
> anyone would be noticing and caring about this warning in a context where
> they couldn't just scroll further up the log and cross-reference the full
> memory map listing? If so, it might be worth clarifying what that use-case
> is, since as it stands there doesn't seem to be much justification for the
> "why" here.

Hi Robin,

Thanks for looking at this.

Honestly, the only justification for the modification/or proposed changes
is to have more insight when this statement is provided in total isolation
and the RAM map listing (as per e820__print_table()) is no longer available
to reference.

> > diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> > index 95b994cf80cd..165e9a444bb9 100644
> > --- a/arch/x86/kernel/e820.c
> > +++ b/arch/x86/kernel/e820.c
> > @@ -1073,7 +1073,7 @@ void __init e820__finish_early_params(void)
> >   const char *__init e820_type_to_string(struct e820_entry *entry)
> >   {
> > -	switch (entry->type) {
> > +	switch (entry && entry->type) {
> 
> Have you tested this for anything other than E820_TYPE_RAM? I think
> sufficiently up-to-date compilers should warn you here anyway.

I have not.


Kind regards,

-- 
Aaron Tomlin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
