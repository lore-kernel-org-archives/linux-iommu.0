Return-Path: <SRS0=JKdE=Z4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79187C43603
	for <iommu@archiver.kernel.org>; Fri,  6 Dec 2019 07:25:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38B0221835
	for <iommu@archiver.kernel.org>; Fri,  6 Dec 2019 07:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiMG+u3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B0221835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1E1ED24E83;
	Fri,  6 Dec 2019 07:25:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yh8LgpmydDBS; Fri,  6 Dec 2019 07:25:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2010124AF8;
	Fri,  6 Dec 2019 07:25:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F761C18DD;
	Fri,  6 Dec 2019 07:25:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F914C077D
 for <iommu@lists.linux-foundation.org>; Fri,  6 Dec 2019 07:25:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 38DEE24B3A
 for <iommu@lists.linux-foundation.org>; Fri,  6 Dec 2019 07:25:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ch5GkfBFTIjj for <iommu@lists.linux-foundation.org>;
 Fri,  6 Dec 2019 07:25:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id ECD4A24AF8
 for <iommu@lists.linux-foundation.org>; Fri,  6 Dec 2019 07:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575617099;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Y7v2oQLxrB4iI/1uGeXDtI77pwnJlzAPEgeGAh9ntwI=;
 b=RiMG+u3wgSd8WHwQnWPgysnfcLe/N46A5szLRUsgNVX3JGMi2cLe3wrEjK7zVYRtLyuOT/
 37xgY213QqbNI0oNusrt0uhHxrZd/wAX48LwWVoWGohpPlL36ba8VXawriinbHKZnWm7Ao
 RXkI8UDOmqVsjPrn/iKoZej/3IlSWyw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-qsIpnmVVO3mSDqCkFSOXmQ-1; Fri, 06 Dec 2019 02:24:57 -0500
Received: by mail-pf1-f200.google.com with SMTP id c23so3469270pfn.5
 for <iommu@lists.linux-foundation.org>; Thu, 05 Dec 2019 23:24:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to;
 bh=AIB8lTmyjQ1iE6SC8YTttmbsLssfZoL3WiO4BiwiKMc=;
 b=hdZUlQhYTPhW2+6hdPX5YsDFq776kDTJ3ppPZsXbiLDEJI81HnPVNCd2sBH+J2uPHQ
 2UJGlXWEHM1LS9fjk+XTwRbOCIcTzrZ8V+xIa3m7Bl2g2Rroj68c8hybpSUjal6qp4LS
 bddRy08CTo6ujlR417x6M6T+negOLlnry0IVw31RuqvJKCuP9+8c1vd/6FXGup9T274w
 vQC6/89MigXK8xy6L5O4tNkZdEqD71Ey7FPNY3CdSZPxTU8mwmBIB7ZlLh8fR8EcmwUj
 GVpu7a70juRmTtgmvIx2uUMZLzHQCqfC1qRBxPe2vkpb38NYFPreMmo4n2kg+JYydOjm
 tiBQ==
X-Gm-Message-State: APjAAAXQWLuuDjInbkCeMJp8k6b42uSTnQXWIgHi1ZLRMNLjlJ7UcRBW
 43qWIWirz6fdpAMlEREWSo/v7xstLr7+eqfHAqEQidSR+I2mdrhBdi2RuAyGAS9hKeaAhfysLr0
 +RfpA8BKwWYVVyfXJYmSBc7dOuxVt0g==
X-Received: by 2002:a17:90b:3115:: with SMTP id
 gc21mr13555354pjb.54.1575617096336; 
 Thu, 05 Dec 2019 23:24:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqwVsVi1ca3vxPsP1VTyZRHHDlpSW3oLFaYXihzDBGnPX5SH+wXp38LtjZ6rnqhQMeWoSXFPxw==
X-Received: by 2002:a17:90b:3115:: with SMTP id
 gc21mr13555339pjb.54.1575617096052; 
 Thu, 05 Dec 2019 23:24:56 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id h128sm15919855pfe.172.2019.12.05.23.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2019 23:24:54 -0800 (PST)
Date: Fri, 6 Dec 2019 00:24:53 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: dmar pte read access not set error messages on hp dl388 gen8
 systems
Message-ID: <20191206072453.5jjwrjedqbjimx45@cantor>
References: <20191202161332.ctc3y5cvdgqwnz7l@cantor>
 <14bbe41c-61e9-d2b6-31cb-67c0b1ad11da@linux.intel.com>
 <20191203095636.epmuinnrpykecfda@cantor>
 <5ce8d57e-25f0-5d28-7408-92c650ba54aa@linux.intel.com>
 <20191204205300.4jiexjqfpnqlcagu@cantor>
 <2d4e0c05-f0ee-d4b1-d2ed-24197811b097@linux.intel.com>
 <20191205022551.janpwjvr4kei5r7c@cantor>
 <d5981dee-d37b-a725-ed94-8864f3dd7602@linux.intel.com>
 <20191205025320.oiulo3msfcggdlv5@cantor>
 <d5fbedce-7a06-79b4-75fa-0aa3cc3ef73b@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <d5fbedce-7a06-79b4-75fa-0aa3cc3ef73b@linux.intel.com>
X-MC-Unique: qsIpnmVVO3mSDqCkFSOXmQ-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/mixed; boundary="5bvdt5po2tuzt5mf"
Content-Disposition: inline
Cc: iommu@lists.linux-foundation.org
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--5bvdt5po2tuzt5mf
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri Dec 06 19, Lu Baolu wrote:
[snip]
>
>Can you please try below change? Let's check whether the afending
>address has been mapped for device 01.00.2.
>
>$ git diff
>diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>index db7bfd4f2d20..d9daf66be849 100644
>--- a/drivers/iommu/iommu.c
>+++ b/drivers/iommu/iommu.c
>@@ -663,6 +663,8 @@ static int=20
>iommu_group_create_direct_mappings(struct iommu_group *group,
>                        ret =3D iommu_map(domain, addr, addr, pg_size,=20
>entry->prot);
>                        if (ret)
>                                goto out;
>+
>+                       dev_info(dev, "Setting identity map [0x%Lx -=20
>0x%Lx] for group %d\n", addr, addr + pg_size, group->id);
>                }
>
>        }
>
>I am doubting that device 01.00.2 is not in the device scope of
>
>[    4.485108] DMAR: RMRR base: 0x000000bdf6f000 end: 0x000000bdf7efff
>
>By the way, does device 01.00.2 works well after binding the driver?
>

When I boot it with passthrough it doesn't get to a point where I can
login. I think the serial console on these systems is tied to the ilo,
so the conserver connection could be making things
worse. Unfortunately the system is remote. I should have more time now
to focus on debugging this.

Attaching console output for the above patch.

Regards,
Jerry

>Best regards,
>baolu
>

--5bvdt5po2tuzt5mf
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=direct-mappings
Content-Transfer-Encoding: quoted-printable

[   21.833145] DMAR: dmar0: Using Queued invalidation
[   21.834960] DMAR: dmar1: Using Queued invalidation
[   21.837860] pci 0000:00:00.0: Adding to iommu group 0
[   21.839733] pci 0000:00:01.0: Adding to iommu group 1
[   21.841601] pci 0000:00:01.1: Adding to iommu group 2
[   21.843410] pci 0000:00:02.0: Adding to iommu group 3
[   21.845652] pci 0000:00:02.1: Adding to iommu group 4
[   21.847473] pci 0000:00:02.2: Adding to iommu group 5
[   21.849299] pci 0000:00:02.3: Adding to iommu group 6
[   21.851163] pci 0000:00:03.0: Adding to iommu group 7
[   21.852918] pci 0000:00:03.1: Adding to iommu group 8
[   21.854720] pci 0000:00:03.2: Adding to iommu group 9
[   21.856761] pci 0000:00:03.3: Adding to iommu group 10
[   21.858998] pci 0000:00:04.0: Adding to iommu group 11
[   21.860937] pci 0000:00:04.1: Adding to iommu group 11
[   21.863149] pci 0000:00:04.2: Adding to iommu group 11
[   21.864941] pci 0000:00:04.3: Adding to iommu group 11
[   21.866744] pci 0000:00:04.4: Adding to iommu group 11
[   21.868567] pci 0000:00:04.5: Adding to iommu group 11
[   21.870458] pci 0000:00:04.6: Adding to iommu group 11
[   21.872254] pci 0000:00:04.7: Adding to iommu group 11
[   21.874231] pci 0000:00:05.0: Adding to iommu group 12
[   21.876047] pci 0000:00:05.2: Adding to iommu group 12
[   21.877908] pci 0000:00:05.4: Adding to iommu group 12
[   21.879814] pci 0000:00:11.0: Adding to iommu group 13
[   21.881684] pci 0000:00:1a.0: Adding to iommu group 14
[   21.883516] pci 0000:00:1c.0: Adding to iommu group 15
[   21.885324] pci 0000:00:1c.7: Adding to iommu group 16
[   21.887116] pci 0000:00:1d.0: Adding to iommu group 17
[   21.888907] pci 0000:00:1e.0: Adding to iommu group 18
[   21.891913] pci 0000:00:1e.0: Using iommu dma mapping
[   21.894001] pci 0000:00:1f.0: Adding to iommu group 19
[   21.895979] pci 0000:00:1f.2: Adding to iommu group 19
[   21.898870] pci 0000:00:1f.2: DMAR: Setting identity map [0xe8000 - 0xe8=
fff]
[   21.901428] pci 0000:00:1f.2: DMAR: Setting identity map [0xf4000 - 0xf4=
fff]
[   21.903790] pci 0000:00:1f.2: DMAR: Setting identity map [0xbdf6e000 - 0=
xbdf6efff]
[   21.906347] pci 0000:00:1f.2: DMAR: Setting identity map [0xbdf6f000 - 0=
xbdf7efff]
[   21.908885] pci 0000:00:1f.2: DMAR: Setting identity map [0xbdf7f000 - 0=
xbdf82fff]
[   21.911620] pci 0000:00:1f.2: DMAR: Setting identity map [0xbdf83000 - 0=
xbdf84fff]
[   21.914141] pci 0000:00:1f.2: DMAR: Device uses a private dma domain.
[   21.916690] pci 0000:03:00.0: Adding to iommu group 20
[   21.919589] pci 0000:03:00.0: Using iommu dma mapping
[   21.921708] pci 0000:03:00.1: Setting identity map [0xe8000 - 0xe9000] f=
or group 20
[   21.924309] pci 0000:03:00.1: Setting identity map [0xf4000 - 0xf5000] f=
or group 20
[   21.926854] pci 0000:03:00.1: Setting identity map [0xbdf6e000 - 0xbdf6f=
000] for group 20
[   21.929560] pci 0000:03:00.1: Setting identity map [0xbdf6f000 - 0xbdf70=
000] for group 20
[   21.932366] pci 0000:03:00.1: Setting identity map [0xbdf00 - 0xbdf71000=
] for group 20
[   22.035075] pci 0000:03:00.1: Setting identity00 - 0xbdf72000] for group=
 20
[   22.437744] pci 0000:03:00.1: Setting identityp [0xbdf72000 - 0xbdf73000=
] for group 20
[   22.540574] pci 0000:03:00.1: Setting identity map [0xbdf73000 - 0xbdf74=
000] for group 20
[   22.543522] pci 0000:03:00.1: Setting identity map [0xbdf74000 - 0xbdf75=
000] for group 20
[   22.546270] pci 0000:03:00.1: Setting identity map [0xbdf75000 - 0xbdf76=
000] for group 20
[   22.548969] pci 0000:03:00.1: Setting identity map [0xbdf76000 - 0xbdf77=
000] for group 20
[   22.551801] pci 0000:03:00.1: Setting identity map [0xbdf77000 - 0xbdf78=
000] for group 20
[   22.554471] pci 0000:03:00.1: Setting identity map [0xbdf78000 - 0xbdf79=
000] for group 20
[   22.557096] pci 0000:03:00.1: Setting identity map [0xbdf79000 - 0xbdf7a=
000] for group 20
[   22.559795] pci 0000:03:00.1: Setting identity map [0xbdf7a000 - 0xbdf7b=
000] for group 20
[   22.562529] pci 0000:03:00.1: Setting identity map [0xbdf7b000 - 0xbdf7c=
000] for group 20
[   22.565240] pci 0000:03:00.1: Setting identity map [0xbdf7c000 - 0xbdf7d=
000] for group 20
[   22.567941] pci 0000:03:00.1: Setting identity map [0xbdf7d000 - 0xbdf7e=
000] for group 20
[   22.570725] pci 0000:03:00.1: Setting identity map [0xbdf7e000 - 0xbdf7f=
000] for group 20
[   22.573472] pci 0000:03:00.1: Setting identity map [0xbdf7f000 - 0xbdf80=
000] for group 20
[   22.576160] pci 0000:03:00.1: Setting identity map [0xbdf80000 - 0xbdf81=
000] for group 20
[   22.578883] pci Setting identity map [0xbdf81000 - 0xbdf82000] for group=
 20
[   22.981597] pci 0000:03:00.1: Setting identity map [0xbdf82000 - 0xbdf83=
000] for group 20
[   22.984383] pci 0000:03:00.1: Setting identity map [0xbdf83000 - 0xbdf84=
000] for group 20
[   22.987477] pci 0000:03:00.1: Setting identity map [0xbdf84000 - 0xbdf85=
000] for group 20
[   22.990217] pci 0000:03:00.1: Adding to iommu group 20
[   22.992042] pci 0000:03:00.2: Adding to iommu group 20
[   22.993837] pci 0000:03:00.3: Adding to iommu group 20
[   22.995635] pci 0000:02:00.0: Adding to iommu group 21
[   22.998067] pci 0000:02:00.0: Using iommu dma mapping
[   22.999885] pci 0000:04:00.0: Adding to iommu group 22
[   23.001683] pci 0000:05:02.0: Adding to iommu group 23
[   23.003458] pci 0000:05:04.0: Adding to iommu group 24
[   23.005189] pci 0000:06:00.0: Adding to iommu group 23
[   23.007671] pci 0000:06:00.0: DMAR: Setting identity map [0xe8000 - 0xe8=
fff]
[   23.010100] pci 0000:06:00.0: DMAR: Setting identity map [0xf4000 - 0xf4=
fff]
[   23.012512] pci 0000:06:00.0: DMAR: Setting identity map [0xbdf6e000 - 0=
xbdf6efff]
[   23.015026] pci 0000:06:00.0: DMAR: Setting identity map [0xbdf6f000 - 0=
xbdf7efff]
[   23.017526] pci 0000:06:00.0: DMAR:map [0xbdf7f000 - 0xbdf82fff]
[   23.519906] pci 0000:06:00.0: DMAR: Setting identity map [0xbdf83000 - 0=
xbdf84fff]
[   23.522565] pci 0000:06:00.0: DMAR: Device uses a private dma domain.
[   23.524746] pci 0000:06:00.1: Adding to iommu group 23
[   23.527624] pci 0000:06:00.1: DMAR: Setting identity map [0xe8000 - 0xe8=
fff]
[   23.530068] pci 0000:06:00.1: DMAR: Setting identity map [0xf4000 - 0xf4=
fff]
[   23.532469] pci 0000:06:00.1: DMAR: Setting identity map [0xbdf6e000 - 0=
xbdf6efff]
[   23.534990] pci 0000:06:00.1: DMAR: Setting identity map [0xbdf6f000 - 0=
xbdf7efff]
[   23.537505] pci 0000:06:00.1: DMAR: Setting identity map [0xbdf7f000 - 0=
xbdf82fff]
[   23.540005] pci 0000:06:00.1: DMAR: Setting identity map [0xbdf83000 - 0=
xbdf84fff]
[   23.542588] pci 0000:06:00.1: DMAR: Device uses a private dma domain.
[   23.544745] pci 0000:07:00.0: Adding to iommu group 24
[   23.547493] pci 0000:07:00.0: DMAR: Setting identity map [0xe8000 - 0xe8=
fff]
[   23.549882] pci 0000:07:00.0: DMAR: Setting identity map [0xf4000 - 0xf4=
fff]
[   23.552241] pci 0000:07:00.0: DMAR: Setting identity map [0xbdf6e000 - 0=
xbdf6efff]
[   23.554781] pci 0000:07:00.0: DMAR: Setting identity  0xbdf7efff]
[   24.057156] pci 0000:07:00.0: DMAR: Setting identity map [0xbdf7f000 - 0=
xbdf82fff]
[   24.059713] pci 0000:07:00.0: DMAR: Setting identity map [0xbdf83000 - 0=
xbdf84fff]
[   24.062355] pci 0000:07:00.0: DMAR: Device uses a private dma domain.
[   24.064527] pci 0000:07:00.1: Adding to iommu group 24
[   24.067080] pci 0000:07:00.1: DMAR: Setting identity map [0xe8000 - 0xe8=
fff]
[   24.069454] pci 0000:07:00.1: DMAR: Setting identity map [0xf4000 - 0xf4=
fff]
[   24.071886] pci 0000:07:00.1: DMAR: Setting identity map [0xbdf6e000 - 0=
xbdf6efff]
[   24.074449] pci 0000:07:00.1: DMAR: Setting identity map [0xbdf6f000 - 0=
xbdf7efff]
[   24.076935] pci 0000:07:00.1: DMAR: Setting identity map [0xbdf7f000 - 0=
xbdf82fff]
[   24.079460] pci 0000:07:00.1: DMAR: Setting identity map [0xbdf83000 - 0=
xbdf84fff]
[   24.082101] pci 0000:07:00.1: DMAR: Device uses a private dma domain.
[   24.084437] pci 0000:01:00.0: Adding to iommu group 25
[   24.087304] pci 0000:01:00.0: Using iommu dma mapping
[   24.089151] pci 0000:01:00.1: Adding to iommu group 25
[   24.090974] pci 0000:01:00.1: DMAR: Device uses a private identity domai=
n.
[   24.093322] pci 0000:01:00.2: Adding to iommu group 25
[   24.095073] pci 0000:01:00iommu group 25
[   24.496813] pci 0000:01:00.4: DMAR: Device uses a private identity domai=
n.
[   24.499147] pci 0000:20:00.0: Adding to iommu group 26
[   24.501024] pci 0000:20:01.0: Adding to iommu group 27
[   24.502809] pci 0000:20:01.1: Adding to iommu group 28
[   24.504565] pci 0000:20:02.0: Adding to iommu group 29
[   24.506303] pci 0000:20:02.1: Adding to iommu group 30
[   24.508073] pci 0000:20:02.2: Adding to iommu group 31
[   24.509843] pci 0000:20:02.3: Adding to iommu group 32
[   24.511726] pci 0000:20:03.0: Adding to iommu group 33
[   24.513520] pci 0000:20:03.1: Adding to iommu group 34
[   24.515275] pci 0000:20:03.2: Adding to iommu group 35
[   24.517049] pci 0000:20:03.3: Adding to iommu group 36
[   24.519033] pci 0000:20:04.0: Adding to iommu group 37
[   24.520935] pci 0000:20:04.1: Adding to iommu group 37
[   24.522714] pci 0000:20:04.2: Adding to iommu group 37
[   24.524498] pci 0000:20:04.3: Adding to iommu group 37
[   24.526242] pci 0000:20:04.4: Adding to iommu group 37
[   24.528055] pci 0000:20:04.5: Adding to iommu group 37
[   24.529829] pci 0000:20:04.6: Adding to iommu group 37
[   24.531694] pci 0000:20:04.7: Adding to iommu group 37
[   24.533545] pci 0000:20:05.0: Adding to iommu group 38
[   24.535316] pci 0000:20:05.2: Adding to iommu group 38
[   24.537106] pci 0000:20:05.4: Adding to iommu group 38
[   24.538893] pci 0000:24:00.0: Adding to iommu group 39
[   24.541532] pci 0000:24:00.0: Using iommu dma mapping
[   24.543317] pci 0000:24:00.1: Adding to iommu group 40
[   24.545811] pci 0000:24:00.1: Using iommu dma mapping
[   24.547663] pci 0000:24:00.2: Adding to iommu group 41
[   24.550232] pci 0000:24:00.2: Using iomm  24.962894] pci 0000:24:00.3: A=
dding to iommu group 42
[   25.054536] pci 0000:24:00.3: Using iommu dma mapping
[   25.056415] pci 0000:1f:08.0: Adding to iommu group 43
[   25.058192] pci 0000:1f:08.3: Adding to iommu group 43
[   25.060061] pci 0000:1f:08.4: Adding to iommu group 43
[   25.061907] pci 0000:1f:09.0: Adding to iommu group 44
[   25.063712] pci 0000:1f:09.3: Adding to iommu group 44
[   25.065540] pci 0000:1f:09.4: Adding to iommu group 44
[   25.067393] pci 0000:1f:0a.0: Adding to iommu group 45
[   25.069174] pci 0000:1f:0a.1: Adding to iommu group 45
[   25.071034] pci 0000:1f:0a.2: Adding to iommu group 45
[   25.072825] pci 0000:1f:0a.3: Adding to iommu group 45
[   25.074653] pci 0000:1f:0b.0: Adding to iommu group 46
[   25.076441] pci 0000:1f:0b.3: Adding to iommu group 46
[   25.078287] pci 0000:1f:0c.0: Adding to iommu group 47
[   25.080119] pci 0000:1f:0c.1: Adding to iommu group 47
[   25.081922] pci 0000:1f:0c.2: Adding to iommu group 47
[   25.083703] pci 0000:1f:0c.6: Adding to iommu group 47
[   25.085509] pci 0000:1f:0c.7: Adding to iommu group 47
[   25.087669] pci 0000:1f:0d.0: Adding to iommu group 48
[   25.089506] pci 0000:1f:0d.1: Adding to iommu group 48
[   25.091349] pci 0000:1f:0d.2: Adding to[   25.558963] pci 0000:1f:0d.6: =
Adding to iommu group 48
[   25.595177] pci 0000:1f:0e.0: Adding to iommu group 49
[   25.597051] pci 0000:1f:0e.1: Adding to iommu group 49
[   25.599218] pci 0000:1f:0f.0: Adding to iommu group 50
[   25.601170] pci 0000:1f:0f.1: Adding to iommu group 50
[   25.603056] pci 0000:1f:0f.2: Adding to iommu group 50
[   25.604894] pci 0000:1f:0f.3: Adding to iommu group 50
[   25.606751] pci 0000:1f:0f.4: Adding to iommu group 50
[   25.608594] pci 0000:1f:0f.5: Adding to iommu group 50
[   25.610436] pci 0000:1f:0f.6: Adding to iommu group 50
[   25.613043] pci 0000:1f:10.0: Adding to iommu group 51
[   25.614906] pci 0000:1f:10.1: Adding to iommu group 51
[   25.616759] pci 0000:1f:10.2: Adding to iommu group 51
[   25.618603] pci 0000:1f:10.3: Adding to iommu group 51
[   25.620458] pci 0000:1f:10.4: Adding to iommu group 51
[   25.622266] pci 0000:1f:10.5: Adding to iommu group 51
[   25.624154] pci 0000:1f:10.6: Adding to iommu group 51
[   25.626088] pci 0000:1f:10.7: Adding to iommu group 51
[   25.627980] pci 0000:1f:11.0: Adding to iommu group 52
[   25.630043] pci 0000:1f:13.0: Adding to iommu  25.931279] pci 0000:1f:13=
.1: Adding to iommu group 53
[   26.033506] pci 0000:1f:13.4: Adding to iommu group 53
[   26.035287] pci 0000:1f:13.5: Adding to iommu group 53
[   26.037070] pci 0000:1f:13.6: Adding to iommu group 53
[   26.038925] pci 0000:3f:08.0: Adding to iommu group 54
[   26.040799] pci 0000:3f:08.3: Adding to iommu group 54
[   26.042586] pci 0000:3f:08.4: Adding to iommu group 54
[   26.044397] pci 0000:3f:09.0: Adding to iommu group 55
[   26.046198] pci 0000:3f:09.3: Adding to iommu group 55
[   26.047991] pci 0000:3f:09.4: Adding to iommu group 55
[   26.049854] pci 0000:3f:0a.0: Adding to iommu group 56
[   26.051740] pci 0000:3f:0a.1: Adding to iommu group 56
[   26.053526] pci 0000:3f:0a.2: Adding to iommu group 56
[   26.055285] pci 0000:3f:0a.3: Adding to iommu group 56
[   26.057294] pci 0000:3f:0b.0: Adding to iommu group 57
[   26.059107] pci 0000:3f:0b.3: Adding to iommu group 57
[   26.061092] pci 0000:3f:0c.0: Adding to iommu group 58
[   26.062881] pci 0000:3f:0c.1: Adding to iommu group 58
[   26.064666] pci 0000:3f:0c.2: Adding to iommu group 58
[   26.066430] pci 0000:3f:0c.6: Adding to iommu group 58
[   26.068214] pci 0g to iommu group 58
[   26.570012] pci 0000:3f:0d.0: Adding to iommu group 59
[   26.571914] pci 0000:3f:0d.1: Adding to iommu group 59
[   26.573717] pci 0000:3f:0d.2: Adding to iommu group 59
[   26.575480] pci 0000:3f:0d.6: Adding to iommu group 59
[   26.577292] pci 0000:3f:0e.0: Adding to iommu group 60
[   26.579095] pci 0000:3f:0e.1: Adding to iommu group 60
[   26.581097] pci 0000:3f:0f.0: Adding to iommu group 61
[   26.582907] pci 0000:3f:0f.1: Adding to iommu group 61
[   26.584692] pci 0000:3f:0f.2: Adding to iommu group 61
[   26.586468] pci 0000:3f:0f.3: Adding to iommu group 61
[   26.588240] pci 0000:3f:0f.4: Adding to iommu group 61
[   26.590054] pci 0000:3f:0f.5: Adding to iommu group 61
[   26.591912] pci 0000:3f:0f.6: Adding to iommu group 61
[   26.593870] pci 0000:3f:10.0: Adding to iommu group 62
[   26.595927] pci 0000:3f:10.1: Adding to iommu group 62
[   26.597721] pci 0000:3f:10.2: Adding to iommu group 62
[   26.599485] pci 0000:3f:10.3: Adding to iommu group 62
[   26.601364] pci 0000:3f:10.4: Adding to iommu group 62
[   26.603161] pci 0000:3f:10.5: Adding to iommu group 62
[   26.604967] pci 0000:3f:10.6: Adding to iommu group 62
[   26.606804] pci 0000:3f:10.7: Adding to iommu group 62
[   26.608566] pci 0000:3f:11.0: Adding to iommu group 63
[   26.610464] pci 0000:3f:13.0: Adding to iommu group 64
[   26.612655] pci 0000:3f:13.1: Adding to iommu group 64
[   26.614433] pci 0000:3f:13.4: Adding to iommu group 64
[   26.616233] pci 0000:3f:13.5: Adding to iommu group 64
[   26.618007] Adding to iommu group 64
[   27.119637] DMAR: Intel(R) Virtualization Technology for Directed I/O
[   27.899649] DMAR: DRHD: handling fault status reg 2
[   27.899649] DMAR: [DMA Read] Request device [02:00.0] PASID ffffffff fau=
lt addr bdf83000 [fault reason 06] PTE Read access is not set
[   27.899649] DMAR: [DMA Read] Request device [01:00.2] PASID ffffffff fau=
lt addr f4000 [fault reason 06] PTE Read access is not set

--5bvdt5po2tuzt5mf
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--5bvdt5po2tuzt5mf--

