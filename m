Return-Path: <SRS0=1rIG=YL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F8ACA9EA0
	for <iommu@archiver.kernel.org>; Fri, 18 Oct 2019 14:48:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E44DE21D7C
	for <iommu@archiver.kernel.org>; Fri, 18 Oct 2019 14:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwpQPnbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44DE21D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 90A76BDC;
	Fri, 18 Oct 2019 14:48:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 580CCB49
	for <iommu@lists.linux-foundation.org>;
	Fri, 18 Oct 2019 14:48:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id BED3A821
	for <iommu@lists.linux-foundation.org>;
	Fri, 18 Oct 2019 14:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1571410090;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=+xUWPDHliBoxc0ihU+NKk1qsJN/0TLVezwKKP1i/PSI=;
	b=XwpQPnbEtf3ilv0j2DNlwQK8EFvVQtAmfdUbFyWITxKJzAlt6WDJJ5DK3Mh+GJhHnqeNl8
	ctHBNLbTlue3YmQsVkCbjKJoxejEipUHQgvdqmnDn+ehNYEsVjIVmkESoyzf9B/tPvP8Zo
	pJlY5gNZJEZSOKrieCBg6IYfjUOWKTs=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
	[209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
	us-mta-374-20KPj8GDPDmbuxzSZNYTkQ-1; Fri, 18 Oct 2019 10:48:08 -0400
Received: by mail-io1-f70.google.com with SMTP id w16so8726439ioc.15
	for <iommu@lists.linux-foundation.org>;
	Fri, 18 Oct 2019 07:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:mail-followup-to:references:mime-version:content-disposition
	:in-reply-to:user-agent;
	bh=0SSL2373lC6DgsMmmsDZmA6zvnlA8UickiHBAjdntOQ=;
	b=SE6mOb/NX7QZye/LSpCDcHazhsmAabjN+9j4uaQC6LfHpc5Mq9itYYkcuHPrgMf7Ja
	vPg47FOdpVff9nun8VMFtsCdEzXqVXVWqQ3pzlLFzHFoOzF7A8EDtUHg6LDAVoSYRYX9
	VMTE+FKoBSoZd//GsoUIFGZhpuVRMjgItQBobgoTb1g8Xpv2AOB10j7/pYU6cjD+enco
	2zMjrcbo+zjb6zrqKKtodCOR6CP+GrZBaSRCaRkze9xAEbedJnw42DomjfJYUYjyBFPQ
	otZZbkK1BlMlJxUUMx2XJWyJnlidH7sFiV5mEPyNLjE2h48tgYzvY+7ML7mW+4/bFU+Q
	pGMg==
X-Gm-Message-State: APjAAAUeTrET+MPfJ42ygFoERdi9Y1LVBfMQwI3sqCDAeIBt00FG4g+p
	XOeWlGPw1BTloBqB+aCBbriWlC8WCMvXV91SxKHtD229Zhpx84gTI57lM61l2KN3wxtg0V2atCI
	2NDKCafqHrquCqfukJFRSaGfo7IJmkw==
X-Received: by 2002:a92:c2:: with SMTP id 185mr10527386ila.92.1571410088307;
	Fri, 18 Oct 2019 07:48:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwWbRwj/fjTBeTuKTGQTT7Fu5ra8qoDURv6eP3usXETnKzvD8vxqCt0UkKoNoyNlAsUsHb8gQ==
X-Received: by 2002:a92:c2:: with SMTP id 185mr10527353ila.92.1571410088007;
	Fri, 18 Oct 2019 07:48:08 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
	by smtp.gmail.com with ESMTPSA id l3sm1778016ioj.7.2019.10.18.07.48.06
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 18 Oct 2019 07:48:07 -0700 (PDT)
Date: Fri, 18 Oct 2019 07:48:05 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/amd: Check PM_LEVEL_SIZE() condition in locked
	section
Message-ID: <20191018144805.ici3ewsvonlgketl@cantor>
Mail-Followup-To: Joerg Roedel <jroedel@suse.de>, Qian Cai <cai@lca.pw>,
	don.brace@microsemi.com, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, jejb@linux.ibm.com,
	esc.storagedev@microsemi.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
References: <20191016225859.j3jq6pt73mn56chn@cantor>
	<577A2A6B-3012-4CDE-BE57-3E0D628572CB@lca.pw>
	<20191018093830.GA26328@suse.de>
MIME-Version: 1.0
In-Reply-To: <20191018093830.GA26328@suse.de>
User-Agent: NeoMutt/20180716
X-MC-Unique: 20KPj8GDPDmbuxzSZNYTkQ-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
Cc: don.brace@microsemi.com, martin.petersen@oracle.com,
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri Oct 18 19, Joerg Roedel wrote:
>On Thu, Oct 17, 2019 at 07:36:51AM -0400, Qian Cai wrote:
>>
>>
>> > On Oct 16, 2019, at 6:59 PM, Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>> >
>> > I guess the mode level 6 check is really for other potential callers
>> > increase_address_space, none exist at the moment, and the condition
>> > of the while loop in alloc_pte should fail if the mode level is 6.
>>
>> Because there is no locking around iommu_map_page(), if there are
>> several concurrent callers of it for the same domain, could it be that
>> it silently corrupt data due to invalid access?
>
>No, that can't happen because increase_address_space locks the domain
>before actually doing anything. So the address space can't grow above
>domain->mode == 6. But what can happen is that the WARN_ON_ONCE triggers
>in there and that the address space is increased multiple times when
>only one increase would be sufficient.
>
>To fix this we just need to check the PM_LEVEL_SIZE() condition again
>when we hold the lock:
>
>From e930e792a998e89dfd4feef15fbbf289c45124dc Mon Sep 17 00:00:00 2001
>From: Joerg Roedel <jroedel@suse.de>
>Date: Fri, 18 Oct 2019 11:34:22 +0200
>Subject: [PATCH] iommu/amd: Check PM_LEVEL_SIZE() condition in locked section
>
>The increase_address_space() function has to check the PM_LEVEL_SIZE()
>condition again under the domain->lock to avoid a false trigger of the
>WARN_ON_ONCE() and to avoid that the address space is increase more
>often than necessary.
>
>Reported-by: Qian Cai <cai@lca.pw>
>Fixes: 754265bcab78 ("iommu/amd: Fix race in increase_address_space()")
>Signed-off-by: Joerg Roedel <jroedel@suse.de>
>---
> drivers/iommu/amd_iommu.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>index 2369b8af81f3..a0639e511ffe 100644
>--- a/drivers/iommu/amd_iommu.c
>+++ b/drivers/iommu/amd_iommu.c
>@@ -1463,6 +1463,7 @@ static void free_pagetable(struct protection_domain *domain)
>  * to 64 bits.
>  */
> static bool increase_address_space(struct protection_domain *domain,
>+				   unsigned long address,
> 				   gfp_t gfp)
> {
> 	unsigned long flags;
>@@ -1471,8 +1472,8 @@ static bool increase_address_space(struct protection_domain *domain,
>
> 	spin_lock_irqsave(&domain->lock, flags);
>
>-	if (WARN_ON_ONCE(domain->mode == PAGE_MODE_6_LEVEL))
>-		/* address space already 64 bit large */
>+	if (address <= PM_LEVEL_SIZE(domain->mode) ||
>+	    WARN_ON_ONCE(domain->mode == PAGE_MODE_6_LEVEL))
> 		goto out;
>
> 	pte = (void *)get_zeroed_page(gfp);
>@@ -1505,7 +1506,7 @@ static u64 *alloc_pte(struct protection_domain *domain,
> 	BUG_ON(!is_power_of_2(page_size));
>
> 	while (address > PM_LEVEL_SIZE(domain->mode))
>-		*updated = increase_address_space(domain, gfp) || *updated;
>+		*updated = increase_address_space(domain, address, gfp) || *updated;
>
> 	level   = domain->mode - 1;
> 	pte     = &domain->pt_root[PM_LEVEL_INDEX(level, address)];
>-- 
>2.16.4
>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
