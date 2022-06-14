Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF59AC43334
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 19:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6687F823C0;
	Tue, 14 Jun 2022 19:01:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ToCLuDTL2oCH; Tue, 14 Jun 2022 19:01:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2A72C82695;
	Tue, 14 Jun 2022 19:01:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBD7BC0039;
	Tue, 14 Jun 2022 19:01:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34E0CC002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 19:01:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1CDFE410D5
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 19:01:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gb_pIjX6s0eH for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 19:01:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E7A89410CF
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 19:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655233310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SAh+GOzRM5ZJKSrACCl7nQjWeiM90GqoVoI/fuo1lHY=;
 b=a4w/oG3yZrhIYO/Flql3/5EeKOjKFznxdLycpIVP90ijdgy8wWQVUuwnxe3KlM9kiYHWSO
 Qd77uy/hZ+9ES7Edhy8xBOFv96jXgf7GSvkgGcVwlC0kOqA4hbup1WfSZ0HJZ6ULkJQ/cP
 JJjmddgX+odD34cyNsAYfHWzjuYLgVI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-a4SRiP_zNbCklaCG5sFkzg-1; Tue, 14 Jun 2022 15:01:49 -0400
X-MC-Unique: a4SRiP_zNbCklaCG5sFkzg-1
Received: by mail-pf1-f197.google.com with SMTP id
 206-20020a6218d7000000b0051893ee2888so4169567pfy.16
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 12:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SAh+GOzRM5ZJKSrACCl7nQjWeiM90GqoVoI/fuo1lHY=;
 b=B1ufaSepqk97kv8vmERTeDmBrZ0xw+d6bxgWgVGGaPHUQVwPIv8JBfSbrdmEWGjyS8
 MLwhzViF+bwwZ7V3oC1QeXOIQU38V2Arx5RamrxgPyb+zlC+YsKqH4kzUzz/JycUtWCF
 1reE45gMwz8UttKyH4DrtoOE+l5JOYCFh3YBjcrplZGT2FCUwsxBRe4ANSNk+UeZfDWi
 5a7RkB27RN+mgH7yukqYY226Yw0Jd/sgmir8D1uTSvWaTbK47YOW1j82K6PJagBJ4QZZ
 zuv7QdLO/Ya2CQ4S7mYDD+/sxslJSU8AwvYUHoXcz5T64Idn3r2WuZm2ekJGGMgYV9+p
 BSyw==
X-Gm-Message-State: AOAM531mQthxrW9mX0DOoyHDqIJpUXAl+P/8m1Ldi1PXCesjRyNFtniO
 dPzVL0weG9905v7R+sn+PHtK6qNCcbNU/bTSYpXjied5x5uF2uHe6RucCmL2Ty/pZI82pIFn6c9
 sJoEPqIy48NaBfa+mwuqP3OvkOkNT8g==
X-Received: by 2002:a63:ff19:0:b0:403:7c60:ae96 with SMTP id
 k25-20020a63ff19000000b004037c60ae96mr5581534pgi.466.1655233308295; 
 Tue, 14 Jun 2022 12:01:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0/yOlBlVpAjgAT0lLPDbPxws5cMgkxTruGHAuqHHujxe+ske9BuknPn+Zqn64BRk4zuXORQ==
X-Received: by 2002:a63:ff19:0:b0:403:7c60:ae96 with SMTP id
 k25-20020a63ff19000000b004037c60ae96mr5581514pgi.466.1655233308009; 
 Tue, 14 Jun 2022 12:01:48 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a17090a8b0500b001ead2406552sm221754pjn.46.2022.06.14.12.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jun 2022 12:01:47 -0700 (PDT)
Date: Tue, 14 Jun 2022 12:01:45 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Steve Wahl <steve.wahl@hpe.com>
Subject: Re: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Message-ID: <20220614190145.dkdwjnqnd7lv6y4n@cantor>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <20220512151309.330068-1-steve.wahl@hpe.com>
 <20220613205734.3x7i46bnsofzerr4@cantor>
 <673eb011-94f4-46b0-f1b4-24a02a269f4e@linux.intel.com>
 <CALzcddsXciFgKOLSkXxx4Rv_rwh21qe8hkyiEET280D8orP6Vw@mail.gmail.com>
 <9c943703-0c2f-b654-a28b-f594bf90bec9@linux.intel.com>
 <CALzcdduU-baVF9VV-NnYD2rKn0YC5hzS_F9udExRE7guvMqXWg@mail.gmail.com>
 <616dc81c-dfc6-d6c6-1eab-de0e9ba4411f@linux.intel.com>
 <Yqi7L9A/ADXpIvN6@swahl-home.5wahls.com>
MIME-Version: 1.0
In-Reply-To: <Yqi7L9A/ADXpIvN6@swahl-home.5wahls.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Dimitri Sivanich <sivanich@hpe.com>, Joerg Roedel <jroedel@suse.de>,
 Russ Anderson <russ.anderson@hpe.com>, Mike Travis <mike.travis@hpe.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Kyung Min Park <kyung.min.park@intel.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>
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

On Tue, Jun 14, 2022 at 11:45:35AM -0500, Steve Wahl wrote:
> On Tue, Jun 14, 2022 at 10:21:29AM +0800, Baolu Lu wrote:
> > On 2022/6/14 09:54, Jerry Snitselaar wrote:
> > > On Mon, Jun 13, 2022 at 6:51 PM Baolu Lu <baolu.lu@linux.intel.com> wrote:
> > > > 
> > > > On 2022/6/14 09:44, Jerry Snitselaar wrote:
> > > > > On Mon, Jun 13, 2022 at 6:36 PM Baolu Lu<baolu.lu@linux.intel.com>  wrote:
> > > > > > On 2022/6/14 04:57, Jerry Snitselaar wrote:
> > > > > > > On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
> > > > > > > > To support up to 64 sockets with 10 DMAR units each (640), make the
> > > > > > > > value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
> > > > > > > > CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
> > > > > > > > set.
> > > > > > > > 
> > > > > > > > If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
> > > > > > > > to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
> > > > > > > > allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
> > > > > > > > remapping doesn't support X2APIC mode x2apic disabled"; and the system
> > > > > > > > fails to boot properly.
> > > > > > > > 
> > > > > > > > Signed-off-by: Steve Wahl<steve.wahl@hpe.com>
> > > > > > > > ---
> > > > > > > > 
> > > > > > > > Note that we could not find a reason for connecting
> > > > > > > > DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
> > > > > > > > it seemed like the two would continue to match on earlier processors.
> > > > > > > > There doesn't appear to be kernel code that assumes that the value of
> > > > > > > > one is related to the other.
> > > > > > > > 
> > > > > > > > v2: Make this value a config option, rather than a fixed constant.  The default
> > > > > > > > values should match previous configuration except in the MAXSMP case.  Keeping the
> > > > > > > > value at a power of two was requested by Kevin Tian.
> > > > > > > > 
> > > > > > > >     drivers/iommu/intel/Kconfig | 6 ++++++
> > > > > > > >     include/linux/dmar.h        | 6 +-----
> > > > > > > >     2 files changed, 7 insertions(+), 5 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> > > > > > > > index 247d0f2d5fdf..fdbda77ac21e 100644
> > > > > > > > --- a/drivers/iommu/intel/Kconfig
> > > > > > > > +++ b/drivers/iommu/intel/Kconfig
> > > > > > > > @@ -9,6 +9,12 @@ config DMAR_PERF
> > > > > > > >     config DMAR_DEBUG
> > > > > > > >        bool
> > > > > > > > 
> > > > > > > > +config DMAR_UNITS_SUPPORTED
> > > > > > > > +    int "Number of DMA Remapping Units supported"
> > > > > > > Also, should there be a "depends on (X86 || IA64)" here?
> > > > > > Do you have any compilation errors or warnings?
> > > > > > 
> > > > > > Best regards,
> > > > > > baolu
> > > > > > 
> > > > > I think it is probably harmless since it doesn't get used elsewhere,
> > > > > but our tooling was complaining to me because DMAR_UNITS_SUPPORTED was
> > > > > being autogenerated into the configs for the non-x86 architectures we
> > > > > build (aarch64, s390x, ppcle64).
> > > > > We have files corresponding to the config options that it looks at,
> > > > > and I had one for x86 and not the others so it noticed the
> > > > > discrepancy.
> > > > 
> > > > So with "depends on (X86 || IA64)", that tool doesn't complain anymore,
> > > > right?
> > > > 
> > > > Best regards,
> > > > baolu
> > > > 
> > > 
> > > Yes, with the depends it no longer happens.
> > 
> > The dmar code only exists on X86 and IA64 arch's. Adding this depending
> > makes sense to me. I will add it if no objections.
> 
> I think that works after Baolu's patchset that makes intel-iommu.h
> private.  I'm pretty sure it wouldn't have worked before that.
> 
> No objections.
> 

Yes, I think applying it with the depends prior to Baolu's change would
still run into the issue from the KTR report if someone compiled without
INTEL_IOMMU enabled.

This was dealing with being able to do something like:

make allmodconfig ARCH=arm64 ; grep DMAR_UNITS .config

and finding CONFIG_DMAR_UNITS_SUPPORTED=64.

Thinking some more though, instead of the depends being on the arch
would depending on DMAR_TABLE or INTEL_IOMMU be more appropriate?

Regards,
Jerry

> --> Steve
> 
> -- 
> Steve Wahl, Hewlett Packard Enterprise

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
