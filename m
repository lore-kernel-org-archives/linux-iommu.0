Return-Path: <SRS0=Oyzs=Z2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_BTC_ID,PDS_BTC_MSGID,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAACC43603
	for <iommu@archiver.kernel.org>; Wed,  4 Dec 2019 20:54:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A596120656
	for <iommu@archiver.kernel.org>; Wed,  4 Dec 2019 20:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AqhgiEDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A596120656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 393BB8851F;
	Wed,  4 Dec 2019 20:53:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F8dwArClCHQp; Wed,  4 Dec 2019 20:53:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 768BA884F0;
	Wed,  4 Dec 2019 20:53:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57506C1DD6;
	Wed,  4 Dec 2019 20:53:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A508C077D
 for <iommu@lists.linux-foundation.org>; Wed,  4 Dec 2019 20:53:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2659C884F0
 for <iommu@lists.linux-foundation.org>; Wed,  4 Dec 2019 20:53:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3pdJ7CuZIAfg for <iommu@lists.linux-foundation.org>;
 Wed,  4 Dec 2019 20:53:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C8186884E9
 for <iommu@lists.linux-foundation.org>; Wed,  4 Dec 2019 20:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575492791;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=FrkXA35psRzLSlJpRkEMORXSUXwQbXw2Rwaz/F+OUXQ=;
 b=AqhgiEDaqGNslG1gUxS++kMWpMZEihDNehG3kYI+a6goLvcmKo0YPyFgjVcFdGSeGqCbvi
 5FXfhsR7gr+YWdoTQppcQtIqwOwq2pVWwZyhNAHi+qLhgKEVYPwHPiFJSl3TKFvhAIUH1i
 +w2fxdvmhLutbO0mng4D4YGh7pBiMPI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-wBxcCfzoMzCIsI348gSqng-1; Wed, 04 Dec 2019 15:53:05 -0500
Received: by mail-qk1-f198.google.com with SMTP id a186so641864qkb.18
 for <iommu@lists.linux-foundation.org>; Wed, 04 Dec 2019 12:53:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=zPgP3B5c5LloNzEyDTOZ+86LhhWRe+DVzl6ulbCny4c=;
 b=GxH/mGW2Cqw/hxUnEHIJti4sG7OiFCZFSbN0VgMwu1NnkVjWLTpIqZNfSfDWSnUdLa
 S48wTN1iVgJZbjhiEJKFojaSqYTAjMAqfZT2xR2XduRVkTsKBZvRPjS1bDz3vdh4kG5r
 zJj/vhz9jENUyyVC8N2pySqJPa0/q1FlqXikHxUQ5veAjXlT/+QitNSPS22W2XcD1nEX
 JDmeM5RDd56Q2vMk5NmeLLooqMRhdzRex7I+NUyKSd7JP08Gm78oPKMLCbzK0r7c2nqH
 58PFYT0m41C91QLlYYUImeMHzvoaI6k2009zaSf2z2e+pTIog2Po+XKSp9ECINP4wWD5
 JaOw==
X-Gm-Message-State: APjAAAUMsPYtg9tU0xAlXaihguw9jf4VnH8Nb/ZwQj5PnP/5/DVzEGdg
 cRYjbHRuD5cVLLdNU+z4VO2GyE2b2dxg0uOyF+QC8PJyrberuQEZKaWBwmGV5dYOO2xfz0wj21h
 FkPAkDAcjh0SpT61HHEuaiIzJ8xVUhg==
X-Received: by 2002:ac8:323a:: with SMTP id x55mr4823198qta.376.1575492784943; 
 Wed, 04 Dec 2019 12:53:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqywrxKaPbiumGHH5/zOUjTiJi31hIdUtZ4D14wIqBt4bcygRnoRfDjbhhA1oLnQ/OQL6NsvhQ==
X-Received: by 2002:ac8:323a:: with SMTP id x55mr4823182qta.376.1575492784587; 
 Wed, 04 Dec 2019 12:53:04 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id 206sm4160497qkf.132.2019.12.04.12.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 12:53:03 -0800 (PST)
Date: Wed, 4 Dec 2019 13:53:00 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: dmar pte read access not set error messages on hp dl388 gen8
 systems
Message-ID: <20191204205300.4jiexjqfpnqlcagu@cantor>
References: <20191202063422.3lyfoerkejig4num@cantor>
 <702d8a8a-88de-bffb-911e-9eb9a6a7845d@linux.intel.com>
 <20191202071406.jpq5qobbtnwhktlc@cantor>
 <20191202161332.ctc3y5cvdgqwnz7l@cantor>
 <14bbe41c-61e9-d2b6-31cb-67c0b1ad11da@linux.intel.com>
 <20191203095636.epmuinnrpykecfda@cantor>
 <5ce8d57e-25f0-5d28-7408-92c650ba54aa@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <5ce8d57e-25f0-5d28-7408-92c650ba54aa@linux.intel.com>
X-MC-Unique: wBxcCfzoMzCIsI348gSqng-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/mixed; boundary="omz5tebd6o7fekfs"
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

--omz5tebd6o7fekfs
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed Dec 04 19, Lu Baolu wrote:
>Hi,
>
>On 12/3/19 5:56 PM, Jerry Snitselaar wrote:
>>On Tue Dec 03 19, Lu Baolu wrote:
>>>Hi,
>>>
>>>On 12/3/19 12:13 AM, Jerry Snitselaar wrote:
>>>>On Mon Dec 02 19, Jerry Snitselaar wrote:
>>>>>On Mon Dec 02 19, Lu Baolu wrote:
>>>>>>Hi,
>>>>>>
>>>>>>On 12/2/19 2:34 PM, Jerry Snitselaar wrote:
>>>>>>>We are seeing DMAR PTE read access not set errors when booting a
>>>>>>>kernel with default passthrough, both with a test kernel and with
>>>>>>>a 5.4.0 kernel. Previously we would see a number of identity mapping=
s
>>>>>>>being set related to the rmrrs, and now they aren't seen and we get
>>>>>>>the dmar pte errors as devices touch those regions. From=20
>>>>>>>what I can tell
>>>>>>>currently df4f3c603aeb ("iommu/vt-d: Remove static=20
>>>>>>>identity map code")
>>>>>>>removed the bit of code in init_dmars that used to set up those
>>>>>>>mappings:
>>>>>>>
>>>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * For each rmrr
>>>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 for each d=
ev attached to rmrr
>>>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 do
>>>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=
=A0 locate drhd for dev, alloc domain for dev
>>>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=
=A0 allocate free domain
>>>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=
=A0 allocate page table entries for rmrr
>>>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=
=A0 if context not allocated for bus
>>>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 allocate and init context
>>>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set present in root table for this =
bus
>>>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=
=A0 init context with domain, translation etc
>>>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 endf=
or
>>>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * endfor
>>>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_info("Setting RMRR:\n");
>>>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for_each_rmrr_units(rmrr) {
>>>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* some BIOS lists non-exist devices in=20
>>>>>>>DMAR table. */
>>>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 for_each_active_dev_scope(rmrr->devices,=20
>>>>>>>rmrr->devices_cnt,
>>>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 i, dev) {
>>>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D =
iommu_prepare_rmrr_dev(rmrr, dev);
>>>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>>>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("Mapping reserved=20
>>>>>>>region failed\n");
>>>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
>>>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>
>>>>>>>si_domain_init now has code that sets identity maps for=20
>>>>>>>devices in rmrrs, but
>>>>>>>only for certain devices.
>>>>>>
>>>>>>On which device, are you seeing this error? Is it a rmrr=20
>>>>>>locked device?
>>>>>>
>>>>>>Best regards,
>>>>>>baolu
>>>>>>
>>>>>
>>>>>Almost all of the messages are for the ilo, but there also is=20
>>>>>a message for
>>>>>the smart array raid bus controller.
>>>>>
>>>>
>>>>Also seeing it with a dl380 gen9 system, where the raid bus controller
>>>>is getting the error.
>>>
>>>Does it help if you remove
>>>
>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (device_is_=
rmrr_locked(dev))
>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>>>
>>>in si_domain_init()?
>>>
>>
>>Unfortunately it still spits out a bunch of error messages.
>
>Can you please show me the whole dmesg?
>
>Best regards,
>-baolu
>

Attaching console output (can't get to a point to actually log in) and
config that is used to build that kernel.

--omz5tebd6o7fekfs
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=dl388-console
Content-Transfer-Encoding: quoted-printable


[    0.000000] Linux version 5.4.0-1.elrdy.x86_64 (mockbuild@x86-vm-08.buil=
d.eng.bos.redhat.com) (gcc version 8.2.1 20180905 (Red Hat 8.2.1-3) (GCC)) =
#1 SMP Tue Nov 26 20:14:26 UTC 2019
[    0.000000] Command line: BOOT_IMAGE=3D(hd0,msdos1)/vmlinuz-5.4.0-1.elrd=
y.x86_64 root=3D/dev/mapper/rhel_hp--dl388g8--07-root ro intel_iommu=3Don k=
sdevice=3Dbootif crashkernel=3Dauto resume=3D/dev/mapper/rhel_hp--dl388g8--=
07-swap rd.lvm.lv=3Drhel_hp-dl388g8-07/root rd.lvm.lv=3Drhel_hp-dl388g8-07/=
swap console=3DttyS1,115200n81
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 by=
tes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009c7ff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000000009c800-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bddabfff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x00000000bddac000-0x00000000bddddfff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x00000000bddde000-0x00000000cfffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fee0ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000c3fffefff] usabl=
e
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: HP ProLiant DL388p Gen8, BIOS P70 07/01/2015
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2294.447 MHz processor
[    0.001492] last_pfn =3D 0xc3ffff max_arch_pfn =3D 0x400000000
[    0.001826] x86/PAT: Configuron [0-7]: WB  WC  UC- UC  WB  WP  UC- WT =
=20
[    0.002255] last_pfn =3D 0xbddac max_arch_pfn =3D 0x400000000
[    0.007931] found SMP MP-table at [mem 0x000f4f80-0x000f4f8f]
[    0.008003] Using GB pages for direct mapping
[    0.008308] RAMDISK: [mem 0x349fc000-0x364f5fff]
[    0.008312] ACPI: Early table checksum verification disabled
[    0.008316] ACPI: RSDP 0x00000000000F4F00 000024 (v02 HP    )
[    0.008320] ACPI: XSDT 0x00000000BDDAED00 0000EC (v01 HP     ProLiant 00=
000002 =EF=BF=BD?   0000162E)
[    0.008325] ACPI: FACP 0x00000000BDDAEE40 0000F4 (v03 HP     ProLiant 00=
000002 =EF=BF=BD?   0000162E)
[    0.008329] ACPI BIOS Warning (bug): Invalid length for FADT/Pm1aControl=
Block: 32, using default 16 (20190816/tbfadt-674)
[    0.008332] ACPI BIOS Warning (bug): Invalid length for FADT/Pm2ControlB=
lock: 32, using default 8 (20190816/tbfadt-674)
[    0.008335] ACPI: DSDT 0x00000000BDDAEF40 0026DC (v01 HP     DSDT     00=
000001 INTL 20030228)
[    0.008338] ACPI: FACS 0x00000000BDDAC140 000040
[    0.008340] ACPI: FACS 0x00000000BDDAC140 000040
[    0.008343] ACPI: SPCR 0x00000000BDDAC180 000050 (v01 HP     S   0000162=
E)
[    0.008346] ACPI: MCFG 0x00000000BDDAC200 00003C (v01 HP     ProLiant 00=
000001      00000000)
[    0.008348] ACPI: HPET 0x00000000BDDAC240 000038 (v01 HP     ProLiant 00=
000002 =EF=BF=BD?   0000162E)
[    0.008351] ACPI: FFFF 0x00000000BDDAC280 000064 (v02 HP     ProLiant 00=
000002 =EF=BF=BD?   0000162E)
[    0.008354] ACPI: SPMI 0x00000000BDDAC300 000040 (v05 HP     ProLiant 00=
000001 =EF=BF=BD?   0000162E)
[    0.008357] ACPI: ERST 0x00000000BDDAC340 000230 (v01 HP     ProLiant 00=
000001 =EF=BF=BD?   0000162E)
[    0.008360] ACPI: APIC 0x00000000BDDAC580 00026A (v01 HP     ProLiant 00=
000002      00000000)
[    0.008363] ACPI: SRAT 0x00000000BDDAC800 000750 (v01 HP     Proliant 00=
000001 =EF=BF=BD?   0000162E)
[    0.008366] ACPI: FFFF 0x00000000BDDACF80 000176 (v01 HP     ProLiant 00=
000001 =EF=BF=BD?   0000162E)
[    0.008369] ACPI: BERT 0x00000000BDDAD100 000030 (v01 HP     ProLiant 00=
000001 =EF=BF=BD?   0000162E)
[    0.008371] ACPI: HEST 0x00000000BDDAD140 0000BC (v01 HP     ProLiant 00=
000001 =EF=BF=BD?   0000162E)
[    0.008374] ACPI: DMAR 0x00000000BDDAD200 000720 (v01 HP     ProLiant 00=
000001 =EF=BF=BD?   0000162E)
[    0.008377] ACPI: FFFF 0x00000000BDDAEC40 000030 (v01 HP     ProLiant 00=
000001      00000000)
[    0.008380] ACPI: PCCT 0x00000000BDDAEC80 00006E (v01 HP     Proliant 00=
000001 PH   0000504D)
[    0.008383] ACPI: SSDT 0x00000000BDDB1640 0007EA (v01 HP     DEV_PCI1 00=
000001 INTL 20120503)
[    0.008386] ACPI:B1E40 000103 (v03 HP     CRSPCI0  00000002 HP   0000000=
1)
[    0.008389] ACPI: SSDT 0x00000000BDDB1F80 000098 (v03 HP     CRSPCI1  00=
000002 HP   00000001)
[    0.008392] ACPI: SSDT 0x00000000BDDB2040 00038A (v02 HP     riser0   00=
000002 INTL 20030228)
[    0.008395] ACPI: SSDT 0x00000000BDDB2400 000536 (v03 HP     riser1a  00=
000002 INTL 20030228)
[    0.008398] ACPI: SSDT 0x00000000BDDB2940 000537 (v03 HP     riser2a  00=
000002 INTL 20030228)
[    0.008400] ACPI: SSDT 0x00000000BDDB2E80 000BB9 (v01 HP     pcc      00=
000001 INTL 20120503)
[    0.008403] ACPI: SSDT 0x00000000BDDB3A40 000377 (v01 HP     pmab     00=
000001 INTL 20120503)
[    0.008406] ACPI: SSDT 0x00000000BDDB3DC0 005524 (v01 HP     pcc2     00=
000001 INTL 20120503)
[    0.008409] ACPI: SSDT 0x00000000BDDB9300 003AEC (v01 INTEL  PPM RCM  00=
000001 INTL 20061109)
[    0.008444] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.008445] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.008446] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.008447] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.008448] SRAT: PXM 0 -> APIC 0x04   0.008448] SRAT: PXM 0 -> APIC 0x0=
5 -> Node 0
[    0.008449] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    0.008450] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    0.008451] SRAT: PXM 0 -> APIC 0x08 -> Node 0
[    0.008452] SRAT: PXM 0 -> APIC 0x09 -> Node 0
[    0.008452] SRAT: PXM 0 -> APIC 0x0a -> Node 0
[    0.008453] S PXM 0 -> APIC 0x0b -> Node 0
[    0.008454] SRAT: PXM 1 -> APIC 0x20 -> Node 1
[    0.008455] SRAT: PXM 1 -> APIC 0x21 -> Node 1
[    0.008456] SRAT: PXM 1 -> APIC 0x22 -> Node 1
[    0.008456] SRAT: PXM 1 -> APIC 0x23 -> Node 1
[    0.008457] SRAT: PXM 1 -> APIC 0x24 -> Node 1
[    0.008458] SRAT: PXM 1 -> APIC 0x25 -> Node 1
[    0.008459] SRAT: PXM 1 -> APIC 0x26 -> Node 1
[    0.008460] SRAT: PXM 1 -> APIC 0x27 -> Node 1
[    0.008460] SRAT: PXM 1 -> APIC 0x28 -> Node 1
[    0.008461] SRAT: PXM 1 -> APIC 0x29 -> Node 1
[    0.008462] SRAT: PXM 1 -> APIC 0x2a -> Node 1
[    0.008463] SRAT: PXM 1 -> APIC 0x2b -> Node 1
[    0.008467] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x83fffffff]
[    0.008469] ACPI: SRAT: Node 1 PXM 1 [mem 0x840000000-0xc3fffffff]
[    0.008482] NODE_DATA(0) allocated [mem 0x83ffd6000-0x83fffffff]
[    0.008511] NODE_DATA(1) allocated [mem 0xc3ffd5000-0xc3fffefff]
[    0.008717] Using crashkernel=3Dauto, the size chosen is a best effort e=
stimation.
[    0.008720] Reserving 160MB of memory at 2864MB for crashkernel (System =
RAM: 49117MB)
[    0.008779] Zone rang8780]   DMA      [mem 0x0000000000001000-0x00000000=
00ffffff]
[    0.008781]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.008782]   Normal   [mem 0x0000000100000000-0x0000000c3fffefff]
[    0.008783]   Device   empty
[    0.008784] Movable zone start for each node
[    0.008788] Early memory node ranges
[    0.008789]   node   0: [mem 0x0000000000001000-0x000000000009bfff]
[    0.008790]   node   0: [mem 0x0000000000100000-0x00000000bddabfff]
[    0.008791]   node   0: [mem 0x0000000100000000-0x000000083fffffff]
[    0.008795]   node   1: [mem 0x0000000840000000-0x0000000c3fffefff]
[    0.008945] Zeroed struct page in unavailable ranges: 8889 pages
[    0.008947] Initmem setup node 0 [mem 0x0000000000001000-0x000000083ffff=
fff]
[    0.028213] Initmem setup node 1 [mem 0x0000000840000000-0x0000000c3fffe=
fff]
[    0.029426] ACPI: PM-Timer IO Port: 0x908
[    0.029439] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.029451] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-=
23
[    0.029455] IOAPIC[1]: apic_id 0, version 32, address 0xfec10000, GSI 24=
-47
[    0.029459] IOAPIC[2]: apic_id 10, version 32, address 0xfec40000, GSI 4=
8-71
[    0.029462] ACPI: INT_SRC_OVR (bus 0 bus_irq  edge)
[    0.029464] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.029469] Using ACPI (MADT) for SMP configuration information
[    0.029471] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.029475] ACPI: SPCR: SPCR table version 1
[    0.029476] ACPI: SPCR: Unexpected SPCR Access Width.  Defaulting to byt=
e size
[    0.029478] ACPI: SPCR: console: uart,mmio,0x0,9600
[    0.029481] smpboot: Allowing 64 CPUs, 40 hotplug CPUs
[    0.029497] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.029499] PM: Registered nosave memory: [mem 0x0009c000-0x0009cfff]
[    0.029500] PM: Registered nosave memory: [mem 0x0009d000-0x0009ffff]
[    0.029500] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.029501] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.029503] PM: Registered nosave memory: [mem 0xbddac000-0xbddddfff]
[    0.029504] PM: Registered nosave memory: [mem 0xbddde000-0xcfffffff]
[    0.029504] PM: Registered nosave memory: [mem 0xd0000000-0xfebfffff]
[    0.029505] PM: Registered nosave memory: [mem 0xfec00000-0xfee0ffffPM: =
Registered nosave memory: [mem 0xfee10000-0xff7fffff]
[    0.029507] PM: Registered nosave memory: [mem 0xff800000-0xffffffff]
[    0.029509] [mem 0xd0000000-0xfebfffff] available for PCI devices
[    0.029510] Booting paravirtualized kernel on bare hardware
[    0.029514] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 1910969940391419 ns
[    0.029516] Detected CPU family 6 model 45 stepping 7
[    0.029518] Warning: Intel Processor - this hardware has not undergone t=
esting by Red Hat and might not be certified. Please consult https://hardwa=
re.redhat.com for certified hardware.
[    0.144563] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:64 nr_cpu_ids:64 =
nr_node_ids:2
[    0.149207] percpu: Embedded 53 pages/cpu s180224 r8192 d28672 u262144
[    0.149272] Built 2 zonelists, mobility grouping on.  Total pages: 12377=
530
[    0.149274] Policy zone: Normal
[    0.149276] Kernel command line: BOOT_IMAGE=3D(hd0,msdos1)/vmlinuz-5.4.0=
-1.elrdy.x86_64 root=3D/dev/mapper/rhel_hp--dl388g8--07-root ro intel_iommu=
=3Don ksdevice=3Dbootif crashkernel=3Dauto resume=3D/dev/mapper/rhel_hp--dl=
388g8--07-swap rd.lvm.lv=3Drhel_hp-dl388g8-07/root rd.lvm.lv=3Drhel_hp-dl38=
8g8-07/swap console=3DttyS1,115200n81
[    0.149abled
[    0.150215] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.188508] Memory: 3115232K/50296088K available (12292K kernel code, 20=
69K rwdata, 4192K rodata, 2388K init, 6204K bss, 1092768K reserved, 0K cma-=
reserved)
[    0.188837] random: get_random_u64 called from cache_random_seq_create+0=
x7c/0x140 with crng_init=3D0
[    0.189039] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D64, =
Nodes=3D2
[    0.189067] Kernel/User page tables isolation: enabled
[    0.189114] ftrace: allocating 37211 entries in 146 pages
[    0.205224] rcu: Hierarchical RCU implementation.
[    0.205226] rcu: =09RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_i=
ds=3D64.
[    0.205227] rcu: RCU calculated value of scheduler-enlistment delay is 1=
00 jiffies.
[    0.205228] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D64
[    0.208512] NR_IRQS: 524544, nr_irqs: 1752, preallocated irqs: 16
[    0.214231] Console: colour VGA+ 80x25
[    4.054980] printk: console [ttyS1] enabled
[    4.056422] mempolicy: Enabling automatic NUMA balancing. Configure with=
 numa_balancing=3D or the kernel.numa_balancing sysctl
[    4.060179] ACPI: Core revision 201908807] clocksource: hpet: mask: 0xff=
ffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    4.464766] APIC: Switch to symmetric I/O mode setup
[    4.466461] DMAR: Host address width 46
[    4.467747] DMAR: DRHD base: 0x000000fbafe000 flags: 0x0
[    4.469646] DMAR: dmar0: reg_base_addr fbafe000 ver 1:0 cap d2078c106f04=
62 ecap f020fe
[    4.472259] DMAR: DRHD base: 0x000000f4ffe000 flags: 0x1
[    4.474048] DMAR: dmar1: reg_base_addr f4ffe000 ver 1:0 cap d2078c106f04=
62 ecap f020fe
[    4.476678] DMAR: RMRR base: 0x000000bdffd000 end: 0x000000bdffffff
[    4.478839] DMAR: RMRR base: 0x000000bdff6000 end: 0x000000bdffcfff
[    4.480929] DMAR: RMRR base: 0x000000bdf83000 end: 0x000000bdf84fff
[    4.483021] DMAR: RMRR base: 0x000000bdf7f000 end: 0x000000bdf82fff
[    4.485108] DMAR: RMRR base: 0x000000bdf6f000 end: 0x000000bdf7efff
[    4.487190] DMAR: RMRR base: 0x000000bdf6e000 end: 0x000000bdf6efff
[    4.489364] DMAR: RMRR base: 0x000000000f4000 end: 0x000000000f4fff
[    4.491802] DMAR: RMRR base: 0x000000000e8000 end: 0x000000000e8fff
[    4.493908] DMAR: RMRR base: 0x000000bddde000 end: 0x000000bdddefff
[    4.496006] DMAR: ATSR flags: 0x0
[    4.497119] DMAR-IR: IOAPIC id 10 under DRHD base  0xfbafe000 IOMMU 0
[    4.499360] DMAR-IR: IOAPIC id 8 under DRHD base  0xf4ffe000 IOMMU 1
[    4.501477] DMAR-IR: RHD base  0xf4ffe000 IOMMU 1
[    5.003403] DMAR-IR: HPET id 0 under DRHD base 0xf4ffe000
[    5.005206] DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out=
 bit.
[    5.005206] DMAR-IR: Use 'intremap=3Dno_x2apic_optout' to override the B=
IOS setting.
[    5.010766] DMAR-IR: Enabled IRQ remapping in xapic mode
[    5.012566] x2apic: IRQ remapping doesn't support X2APIC mode
[    5.014503] Switched APIC routing to physical flat.
[    5.016757] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    5.023774] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x2112b762dc5, max_idle_ns: 440795270470 ns
[    5.027299] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 4588.89 BogoMIPS (lpj=3D2294447)
[    5.028298] pid_max: default: 65536 minimum: 512
[    5.029408] LSM: Security Framework initializing
[    5.030317] Yama: becoming mindful.
[    5.031317] SELinux:  Initializing.
[    5.045044] Dentry cache hash table entries: 8388608 (order: 14, 6710886=
4 bytes, vmalloc)
[    5.051886] Inode-cache hash table entries: 4194304 (order: 13, 33554432=
 bytes, vmalloc)
[    5.052555] Mount-cache hash table entrder: 8, 1048576 bytes, vmalloc)
[    5.053491] Mountpoint-cache hash table entries: 131072 (order: 8, 10485=
76 bytes, vmalloc)
[    5.054882] mce: CPU0: Thermal monitoring enabled (TM1)
[    5.055318] process: using mwait in idle threads
[    5.056300] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    5.057298] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    5.058301] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    5.059299] Spectre V2 : Mitigation: Full generic retpoline
[    5.060298] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    5.061298] Speculative Store Bypass: Vulnerable
[    5.062300] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    5.063542] Freeing SMP alternatives memory: 32K
[    5.065799] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-2630 0 @ 2.30GHz (fam=
ily: 0x6, model: 0x2d, stepping: 0x7)
[    5.066495] Performance Events: PEBS fmt1+, SandyBridge events, 16-deep =
LBR, full-width counters, Broken BIOS detected, complain to your hardware v=
endor.
[    5.067299] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR=
 38d is 330)
[    5.068298] Intel PMU driver.
[    5.069254] ... version:                3
[    5.069298] ... bit width:              48
[    5.070298] ... generic registers:      4
.. max period:             00007fffffffffff0000ffffffffffff
[    5.073298] ... fixed-purpose events:   3
[    5.074298] ... event mask:             000000070000000f
[    5.075369] rcu: Hierarchical SRCU implementation.
[    5.081198] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    5.082350] smp: Bringing up secondary CPUs ...
[    5.083442] x86: Booting SMP configuration:
[    5.084301] .... node  #0, CPUs:        #1  #2  #3  #4  #5
[    5.095299] .... node  #1, CPUs:    #6
[    4.789532] smpboot: CPU 6 Converting physical 0 to logical die 1
[    5.161533]   #7  #8  #9 #10 #11
[    5.172300] .... node  #0, CPUs:   #12
[    5.174555] MDS CPU bug present and SMT on, data leak possible. See http=
s://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more de=
tails.
[    5.176471]  #13 #14 #15 #16 #17
[    5.186301] .... node  #1, CPUs:   #18 #19 #20 #21 #22 #23
[    5.198511] smp: Brought up 2 nodes, 24 CPUs
[    5.200299] smpboot: Max logical packages: 6
[    5.201300] smpboot: Total of 24 processors activated (110202.88 BogoMIP=
S)
[    5.312320] node 1 initialised, 4094148 pages in 108ms
[    5.455337] node 0 initialised, 7427874 pages in 251ms
[    5.460037] devtmpfs: initialized
[    5.460405] x86/mm: Memory block size: 128MB
[    5.479552] clocksource: jiffies: mask: 0ffffff max_cycles: 0xffffffff, =
max_idle_ns: 1911260446275000 ns
[    5.582402] futex hash table entries: 16384 (order: 8, 1048576 bytes, vm=
alloc)
[    5.586012] pinctrl core: initialized pinctrl subsystem
[    5.587885] NET: Registered protocol family 16
[    5.589620] audit: initializing netlink subsys (disabled)
[    5.591341] audit: type=3D2000 audit(1575474035.594:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    5.594307] cpuidle: using governor menu
[    5.596341] Detected 1 PCC Subspaces
[    5.597400] Registering PCC driver as Mailbox controller
[    5.599546] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    5.602302] ACPI: bus type PCI registered
[    5.603301] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    5.606551] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xc0000000=
-0xcfffffff] (base 0xc0000000)
[    5.609306] PCI: MMCONFIG at [mem 0xc0000000-0xcfffffff] reserved in E82=
0
[    5.611329] PCI: Using configuration type 1 for base access
[    5.613406] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    5.628303] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    5.633433] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    5.636305] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    5.734389] cryptd: max_cpu_qlen set to 1000
[    5.755535] ACPI: Added _OSI(Module Device)
[    5.757304] ACPI: Added _OSI(Processor Device)
[    5.758300] ACPI: Added _OSI(3.0 _SCP Extension5.872309] ACPI: Added _OS=
I(Processor Aggregator Device)
[    6.061308] ACPI: Added _OSI(Linux-Dell-Video)
[    6.062302] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    6.064299] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    6.070883] ACPI: 11 ACPI AML tables successfully acquired and loaded
[    6.075858] ACPI: Interpreter enabled
[    6.077312] ACPI: (supports S0 S4 S5)
[    6.078299] ACPI: Using IOAPIC for interrupt routing
[    6.080318] HEST: Table parsing has been initialized.
[    6.082300] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    6.091761] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-1f])
[    6.093304] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    6.097384] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplu=
g SHPCHotplug PME AER PCIeCapability LTR]
[    6.100300] acpi PNP0A08:00: _OSC: not requesting control; platform does=
 not support [PCIeCapability]
[    6.104300] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug SHPCHotplug=
 PME AER PCIeCapability LTR]
[    6.107299] acpi PNP0A08:00: _OSC: platform willing to grant []
[    6.109299] acpi PNP0A08:00: _OSC failed (AE_SUPPORT); disabling ASPM
[    6.111479] PCI host bridge to bus 0000:00
[    6.112301] pci_bus 0000:0source [mem 0xf4000000-0xf7ffffff window]
[    6.514317] pci_bus 0000:00: root bus resource [io  0x1000-0x7fff window=
]
[    6.517304] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window=
]
[    6.519299] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window=
]
[    6.521299] pci_bus 0000:00: root bus resource [io  0x0d00-0x0fff window=
]
[    6.524299] pci_bus 0000:00: root bus resource [io  0x03b0-0x03bb window=
]
[    6.526299] pci_bus 0000:00: root bus resource [io  0x03c0-0x03df window=
]
[    6.528299] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    6.531299] pci_bus 0000:00: root bus resource [bus 00-1f]
[    6.532313] pci 0000:00:00.0: [8086:3c00] type 00 class 0x060000
[    6.534384] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    6.537390] pci 0000:00:01.0: [8086:3c02] type 01 class 0x060400
[    6.539394] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    6.541435] pci 0000:00:01.1: [8086:3c03] type 01 class 0x060400
[    6.543394] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    6.545425] pci 0000:00:02.0: [8086:3c04] type 01 class 0x060400
[    6.547392] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    6.550423] pci 0000:00:02.1: [8086:3c05] type 01 class 0x060400
[    6.552391] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[  00:00:02.2: [8086:3c06] type 01 class 0x060400
[    7.055402] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    7.057555] pci 0000:00:02.3: [8086:3c07] type 01 class 0x060400
[    7.060430] pci 0000:00:02.3: PME# supported from D0 D3hot D3cold
[    7.062502] pci 0000:00:03.0: [8086:3c08] type 01 class 0x060400
[    7.064360] pci 0000:00:03.0: enabling Extended Tags
[    7.066373] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    7.068498] pci 0000:00:03.1: [8086:3c09] type 01 class 0x060400
[    7.070426] pci 0000:00:03.1: PME# supported from D0 D3hot D3cold
[    7.072493] pci 0000:00:03.2: [8086:3c0a] type 01 class 0x060400
[    7.075428] pci 0000:00:03.2: PME# supported from D0 D3hot D3cold
[    7.077491] pci 0000:00:03.3: [8086:3c0b] type 01 class 0x060400
[    7.079426] pci 0000:00:03.3: PME# supported from D0 D3hot D3cold
[    7.081506] pci 0000:00:04.0: [8086:3c20] type 00 class 0x088000
[    7.083328] pci 0000:00:04.0: reg 0x10: [mem 0xf6cf0000-0xf6cf3fff 64bit=
]
[    7.086512] pci 0000:00:04.1: [8086:3c21] type 00 class 0x088000
[    7.088325] pci 0000:00:04.1: reg 0x10: [mem 0xf6ce0000-0xf6ce3fff 64bit=
]
[    7.090520] pci 0000:00:04.2: [8086:3c22] type 00 class 0x088000
[    7.093326] peg 0x10: [mem 0xf6cd0000-0xf6cd3fff 64bit]
[    7.593460] pci 0000:00:04.3: [8086:3c23] type 00 class 0x088000
[    7.596321] pci 0000:00:04.3: reg 0x10: [mem 0xf6cc0000-0xf6cc3fff 64bit=
]
[    7.598445] pci 0000:00:04.4: [8086:3c24] type 00 class 0x088000
[    7.600319] pci 0000:00:04.4: reg 0x10: [mem 0xf6cb0000-0xf6cb3fff 64bit=
]
[    7.603442] pci 0000:00:04.5: [8086:3c25] type 00 class 0x088000
[    7.605316] pci 0000:00:04.5: reg 0x10: [mem 0xf6ca0000-0xf6ca3fff 64bit=
]
[    7.607431] pci 0000:00:04.6: [8086:3c26] type 00 class 0x088000
[    7.609316] pci 0000:00:04.6: reg 0x10: [mem 0xf6c90000-0xf6c93fff 64bit=
]
[    7.612441] pci 0000:00:04.7: [8086:3c27] type 00 class 0x088000
[    7.614316] pci 0000:00:04.7: reg 0x10: [mem 0xf6c80000-0xf6c83fff 64bit=
]
[    7.616429] pci 0000:00:05.0: [8086:3c28] type 00 class 0x088000
[    7.618434] pci 0000:00:05.2: [8086:3c2a] type 00 class 0x088000
[    7.620435] pci 0000:00:05.4: [8086:3c2c] type 00 class 0x080020
[    7.623312] pci 0000:00:05.4: reg 0x10: [mem 0xf6c70000-0xf6c70fff]
[    7.625427] pci 0000:00:11.0: [8086:1d3e] type 01 class 0x060400
[    7.627413] pci 0000:00:11.0: PME# supported from D0 D3hot D3cold
[    7.629436] pci 0000:00:1a.0: [8086:1d2d] type 00 class 0x0c0320
[    7.631320] pci 0000:00:1a.0: reg 0x10: [mem 0xf6c60000-0xf6c603ff]
[    7.633383] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    7.635386] pci 0000:00:1c.0: [8086:1d10] type 01 class 0x060400
[    7.638392] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    7.640325] pci 000abling UPDCR peer decodes
[    8.040324] pci 0000:00:1c.0: Enabling MPC IRBNCE
[    8.042300] pci 0000:00:1c.0: Intel PCH root port ACS workaround enabled
[    8.044416] pci 0000:00:1c.7: [8086:1d1e] type 01 class 0x060400
[    8.047381] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
[    8.049316] pci 0000:00:1c.7: Enabling MPC IRBNCE
[    8.050299] pci 0000:00:1c.7: Intel PCH root port ACS workaround enabled
[    8.053415] pci 0000:00:1d.0: [8086:1d26] type 00 class 0x0c0320
[    8.055319] pci 0000:00:1d.0: reg 0x10: [mem 0xf6c50000-0xf6c503ff]
[    8.057380] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    8.059380] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    8.061409] pci 0000:00:1f.0: [8086:1d41] type 00 class 0x060100
[    8.063484] pci 0000:00:1f.2: [8086:1d00] type 00 class 0x01018f
[    8.066315] pci 0000:00:1f.2: reg 0x10: [io  0x4000-0x4007]
[    8.068306] pci 0000:00:1f.2: reg 0x14: [io  0x4008-0x400b]
[    8.069305] pci 0000:00:1f.2: reg 0x18: [io  0x4010-0x4017]
[    8.071305] pci 0000:00:1f.2: reg 0x1c: [io  0x4018-0x401b]
[    8.073305] pci 0000:00:1f.2: reg 0x20: [io  0x4020-0x402f]
[    8.075305] pci 0000:00:1f.2: reg 0x24: [io  0x4030-0x403f]
[    8.077637] pci 0000:00:01.0: PCI bridge to [bus 08]
[    8.079340] pci 0000:00:01.1: PCI bridge to [bus 14]
[    8.081386] pci 0000:03:00.0: [14e4:1657] type 00 class 0x020000
[    8.083318] pci 0000:0[mem 0xf6bf0000-0xf6bfffff 64bit pref]
[    8.584325] pci 0000:03:00.0: reg 0x18: [mem 0xf6be0000-0xf6beffff 64bit=
 pref]
[    8.586307] pci 0000:03:00.0: reg 0x20: [mem 0xf6bd0000-0xf6bdffff 64bit=
 pref]
[    8.589305] pci 0000:03:00.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    8.591355] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    8.593409] pci 0000:03:00.1: [14e4:1657] type 00 class 0x020000
[    8.596318] pci 0000:03:00.1: reg 0x10: [mem 0xf6bc0000-0xf6bcffff 64bit=
 pref]
[    8.598307] pci 0000:03:00.1: reg 0x18: [mem 0xf6bb0000-0xf6bbffff 64bit=
 pref]
[    8.601307] pci 0000:03:00.1: reg 0x20: [mem 0xf6ba0000-0xf6baffff 64bit=
 pref]
[    8.603304] pci 0000:03:00.1: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    8.605354] pci 0000:03:00.1: PME# supported from D0 D3hot D3cold
[    8.607399] pci 0000:03:00.2: [14e4:1657] type 00 class 0x020000
[    8.609318] pci 0000:03:00.2: reg 0x10: [mem 0xf6b90000-0xf6b9ffff 64bit=
 pref]
[    8.612307] pci 0000:03:00.2: reg 0x18: [mem 0xf6b80000-0xf6b8ffff 64bit=
 pref]
[    8.614307] pci 0000:03:00.2: reg 0x20: [mem 0xf6b70000-0xf6b7ffff 64bit=
 pref]
[    8.617304] pci 0000:03:00.2: 0000000-0x0003ffff pref]
[    9.118372] pci 0000:03:00.2: PME# supported from D0 D3hot D3cold
[    9.120397] pci 0000:03:00.3: [14e4:1657] type 00 class 0x020000
[    9.122318] pci 0000:03:00.3: reg 0x10: [mem 0xf6b60000-0xf6b6ffff 64bit=
 pref]
[    9.125308] pci 0000:03:00.3: reg 0x18: [mem 0xf6b50000-0xf6b5ffff 64bit=
 pref]
[    9.127307] pci 0000:03:00.3: reg 0x20: [mem 0xf6b40000-0xf6b4ffff 64bit=
 pref]
[    9.129304] pci 0000:03:00.3: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    9.132353] pci 0000:03:00.3: PME# supported from D0 D3hot D3cold
[    9.137346] pci 0000:00:02.0: PCI bridge to [bus 03]
[    9.139306] pci 0000:00:02.0:   bridge window [mem 0xf6b00000-0xf6bfffff=
 64bit pref]
[    9.141335] pci 0000:00:02.1: PCI bridge to [bus 15]
[    9.143350] pci 0000:02:00.0: [103c:323b] type 00 class 0x010400
[    9.145311] pci 0000:02:00.0: reg 0x10: [mem 0xf7d00000-0xf7dfffff 64bit=
]
[    9.147305] pci 0000:02:00.0: reg 0x18: [mem 0xf7cf0000-0xf7cf03ff 64bit=
]
[    9.149303] pci 0000:02:00.0: reg 0x20: [io  0x5000-0x50ff]
[    9.151307] pci 0000:02:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    9.154302] pci 0000:02:00.0: enabling Extended Tags
[    9.1553:00.0: PME# supported from D0 D1 D3hot
[    9.557378] pci 0000:00:02.2: PCI bridge to [bus 02]
[    9.558301] pci 0000:00:02.2:   bridge window [io  0x5000-0x5fff]
[    9.560300] pci 0000:00:02.2:   bridge window [mem 0xf7c00000-0xf7dfffff=
]
[    9.563336] pci 0000:00:02.3: PCI bridge to [bus 16]
[    9.564548] pci 0000:04:00.0: [111d:8018] type 01 class 0x060400
[    9.567346] pci 0000:04:00.0: enabling Extended Tags
[    9.568343] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    9.574323] pci 0000:00:03.0: PCI bridge to [bus 04-07]
[    9.576301] pci 0000:00:03.0:   bridge window [io  0x6000-0x7fff]
[    9.578300] pci 0000:00:03.0:   bridge window [mem 0xf7e00000-0xf7ffffff=
]
[    9.581344] pci 0000:05:02.0: [111d:8018] type 01 class 0x060400
[    9.583345] pci 0000:05:02.0: enabling Extended Tags
[    9.584348] pci 0000:05:02.0: PME# supported from D0 D3hot D3cold
[    9.587371] pci 0000:05:04.0: [111d:8018] type 01 class 0x060400
[    9.589345] pci 0000:05:04.0: enabling Extended Tags
[    9.591348] pci 0000:05:04.0: PME# supported from D0 D3hot D3cold
[    9.593375] pci 0000:04:00.0: PCI bridge to [bus 05-07]
[    9.595303] pci 0000:04:00.0:   bridge window [io  0x6000-0x7fff]
[    9.597301] pci 0000:04:00.0:   bridge window [mem 0xf7e00000-0xf7ffffff=
]
[    9.599347] pci 0000bc] type 00 class 0x020000
[   10.100341] pci 0000:06:00.0: reg 0x10: [mem 0xf7ee0000-0xf7efffff]
[   10.102308] pci 0000:06:00.0: reg 0x14: [mem 0xf7ec0000-0xf7edffff]
[   10.104308] pci 0000:06:00.0: reg 0x18: [io  0x6000-0x601f]
[   10.106334] pci 0000:06:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[   10.108377] pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
[   10.110441] pci 0000:06:00.1: [8086:10bc] type 00 class 0x020000
[   10.113332] pci 0000:06:00.1: reg 0x10: [mem 0xf7ea0000-0xf7ebffff]
[   10.115312] pci 0000:06:00.1: reg 0x14: [mem 0xf7e80000-0xf7e9ffff]
[   10.117313] pci 0000:06:00.1: reg 0x18: [io  0x6020-0x603f]
[   10.119345] pci 0000:06:00.1: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[   10.121379] pci 0000:06:00.1: PME# supported from D0 D3hot D3cold
[   10.126325] pci 0000:05:02.0: PCI bridge to [bus 06]
[   10.128309] pci 0000:05:02.0:   bridge window [io  0x6000-0x6fff]
[   10.130304] pci 0000:05:02.0:   bridge window [mem 0xf7e00000-0xf7efffff=
]
[   10.132381] pci 0000:07:00.0: [8086:10bc] type 00 class 0x020000
[   10.135330] pci 0000:07:00.0: reg 0x10: [mem 0xf7fe0000-0xf7ffffff]
[   10.137312] pci 0000:07:00.0: reg 0x14: [mem 0xf7fc0000-0xf7fdffff]
[   10.139312] pci 0000:0[io  0x7000-0x701f]
[   10.639354] pci 0000:07:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[   10.641360] pci 0000:07:00.0: PME# supported from D0 D3hot
[   10.643383] pci 0000:07:00.1: [8086:10bc] type 00 class 0x020000
[   10.645322] pci 0000:07:00.1: reg 0x10: [mem 0xf7fa0000-0xf7fbffff]
[   10.648308] pci 0000:07:00.1: reg 0x14: [mem 0xf7f80000-0xf7f9ffff]
[   10.650308] pci 0000:07:00.1: reg 0x18: [io  0x7020-0x703f]
[   10.652334] pci 0000:07:00.1: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[   10.654359] pci 0000:07:00.1: PME# supported from D0 D3hot
[   10.659323] pci 0000:05:04.0: PCI bridge to [bus 07]
[   10.660303] pci 0000:05:04.0:   bridge window [io  0x7000-0x7fff]
[   10.662302] pci 0000:05:04.0:   bridge window [mem 0xf7f00000-0xf7ffffff=
]
[   10.665357] pci 0000:00:03.1: PCI bridge to [bus 17]
[   10.666340] pci 0000:00:03.2: PCI bridge to [bus 18]
[   10.668340] pci 0000:00:03.3: PCI bridge to [bus 19]
[   10.670351] pci 0000:00:11.0: PCI bridge to [bus 1b]
[   10.672578] pci 0000:00:1c.0: PCI bridge to [bus 0b]
[   10.673373] pci 0000:01:00.0: [103c:3306] type 00 class 0x088000
[   10.676330] pci 0000:01:00.0: reg 0x10: [io  0x3000-0x30ff]
[   10.677312] pci 0000:01:00.0: reg 0x14: [mem 0xf7bf0000-0xf7bf01ff]
[   10.680312] pci 0000:01:00.0: reg 0x18: [io  0x3400-0x34ff]
[   10.681526] pci 0000:01:00.1: [102b:0533] type 00 class 0x030000
[   10.684331] pci 0000:01:00.1: reg 0x10: [mem 0xf5000000-0xf5ffffff pref]
[   10.686312] pci 0000:01:00.1: reg 0x14: [mem 0xf7be0000-0xf7be3fff]
[   10.6883110.1: reg 0x18: [mem 0xf7000000-0xf77fffff]
[   11.089433] pci 0000:01:00.2: [103c:3307] type 00 class 0x088000
[   11.092339] pci 0000:01:00.2: reg 0x10: [io  0x3800-0x38ff]
[   11.094316] pci 0000:01:00.2: reg 0x14: [mem 0xf6ff0000-0xf6ff00ff]
[   11.096316] pci 0000:01:00.2: reg 0x18: [mem 0xf6e00000-0xf6efffff]
[   11.098316] pci 0000:01:00.2: reg 0x1c: [mem 0xf6d80000-0xf6dfffff]
[   11.100316] pci 0000:01:00.2: reg 0x20: [mem 0xf6d70000-0xf6d77fff]
[   11.102316] pci 0000:01:00.2: reg 0x24: [mem 0xf6d60000-0xf6d67fff]
[   11.104317] pci 0000:01:00.2: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[   11.106393] pci 0000:01:00.2: PME# supported from D0 D3hot D3cold
[   11.109420] pci 0000:01:00.4: [103c:3300] type 00 class 0x0c0300
[   11.111394] pci 0000:01:00.4: reg 0x20: [io  0x3c00-0x3c1f]
[   11.116331] pci 0000:00:1c.7: PCI bridge to [bus 01]
[   11.118306] pci 0000:00:1c.7:   bridge window [io  0x3000-0x3fff]
[   11.120304] pci 0000:00:1c.7:   bridge window [mem 0xf6d00000-0xf7bfffff=
]
[   11.122306] pci 0000:00:1c.7:   bridge window [mem 0xf5000000-0xf5ffffff=
 64bit pref]
[   11.125326] pci_bus 0000:1a: extended config space not accessible
[   11.127373] pci 0000:00:1e.0: PCI bridge to [bus 1a] (subtractive decode=
)
[   11.129312] pci 0dge window [mem 0xf4000000-0xf7ffffff window] (subtract=
ive decode)
[   11.630318] pci 0000:00:1e.0:   bridge window [io  0x1000-0x7fff window]=
 (subtractive decode)
[   11.633299] pci 0000:00:1e.0:   bridge window [io  0x0000-0x03af window]=
 (subtractive decode)
[   11.636299] pci 0000:00:1e.0:   bridge window [io  0x03e0-0x0cf7 window]=
 (subtractive decode)
[   11.639299] pci 0000:00:1e.0:   bridge window [io  0x0d00-0x0fff window]=
 (subtractive decode)
[   11.642299] pci 0000:00:1e.0:   bridge window [io  0x03b0-0x03bb window]=
 (subtractive decode)
[   11.644299] pci 0000:00:1e.0:   bridge window [io  0x03c0-0x03df window]=
 (subtractive decode)
[   11.647299] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff=
 window] (subtractive decode)
[   11.650680] ACPI: PCI Interrupt Link [LNKA] (IRQs *5 7 10 11)
[   11.653341] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *7 10 11)
[   11.655338] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 7 *10 11)
[   11.657337] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 *10 11)
[   11.659337] ACPI: PCI Interrupt Link [LNKE] (IRQs *5 7 10 11)
[   11.661338] ACPI: PCI Interrupt Link [LNKF] (IRQs 5 *7 10 11)
[   11.663337] ACPI: PCI Interrupt Link [LNKG] (IRQs 5 7 10 11) *0, disable=
d.
[   11.665337] ACPI: PCI Interrupt Link [LNKH] (IRQs 5 7 10 11) *0, disable=
d.
[   11.667320ridge [PCI1] (domain 0000 [bus 20-3f])
[   12.168327] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[   12.171379] acpi PNP0A08:01: _OSC: platform does not support [PCIeHotplu=
g SHPCHotplug PME AER PCIeCapability LTR]
[   12.175300] acpi PNP0A08:01: _OSC: not requesting control; platform does=
 not support [PCIeCapability]
[   12.178299] acpi PNP0A08:01: _OSC: OS requested [PCIeHotplug SHPCHotplug=
 PME AER PCIeCapability LTR]
[   12.181299] acpi PNP0A08:01: _OSC: platform willing to grant []
[   12.183299] acpi PNP0A08:01: _OSC failed (AE_SUPPORT); disabling ASPM
[   12.185396] PCI host bridge to bus 0000:20
[   12.186300] pci_bus 0000:20: root bus resource [mem 0xf8000000-0xfbfffff=
f window]
[   12.189299] pci_bus 0000:20: root bus resource [io  0x8000-0xffff window=
]
[   12.191299] pci_bus 0000:20: root bus resource [bus 20-3f]
[   12.193312] pci 0000:20:00.0: [8086:3c01] type 01 class 0x060400
[   12.195392] pci 0000:20:00.0: PME# supported from D0 D3hot D3cold
[   12.197388] pci 0000:20:01.0: [8086:3c02] type 01 class 0x060400
[   12.199398] pci 0000:20:01.0: PME# supported from D0 D3hot D3cold
[   12.201400] pci 0000:20:01.1: [8086:3c03] type 01 class 0x060400
[   12.203398] pci 0000:20:01.1: PME# supp3hot D3cold
[   12.604422] pci 0000:20:02.0: [8086:3c04] type 01 class 0x060400
[   12.607402] pci 0000:20:02.0: PME# supported from D0 D3hot D3cold
[   12.609400] pci 0000:20:02.1: [8086:3c05] type 01 class 0x060400
[   12.611398] pci 0000:20:02.1: PME# supported from D0 D3hot D3cold
[   12.613397] pci 0000:20:02.2: [8086:3c06] type 01 class 0x060400
[   12.615398] pci 0000:20:02.2: PME# supported from D0 D3hot D3cold
[   12.617403] pci 0000:20:02.3: [8086:3c07] type 01 class 0x060400
[   12.620397] pci 0000:20:02.3: PME# supported from D0 D3hot D3cold
[   12.622401] pci 0000:20:03.0: [8086:3c08] type 01 class 0x060400
[   12.624344] pci 0000:20:03.0: enabling Extended Tags
[   12.626354] pci 0000:20:03.0: PME# supported from D0 D3hot D3cold
[   12.628406] pci 0000:20:03.1: [8086:3c09] type 01 class 0x060400
[   12.630397] pci 0000:20:03.1: PME# supported from D0 D3hot D3cold
[   12.632402] pci 0000:20:03.2: [8086:3c0a] type 01 class 0x060400
[   12.634397] pci 0000:20:03.2: PME# supported from D0 D3hot D3cold
[   12.636397] pci 0000:20:03.3: [8086:3c0b] type 01 class 0x060400
[   12.638398] pci 0000:20:03.3: PME# supported from D0 D3hot D3cold
[   12.641409] pci 0000:20:04.0: [8086:3c20] type 00 class 0x088000
[   12.643318] pci 0000:20:04.0: reg 0x10: [mem 0xfbbf0000-0xfbbf3fff 64bit=
]
[   12.645434] pci 0000:20:04.1: [8086:3c21] type 00 class 0x088000
[   12.648317] pci 0000:20:04.1: reg 0x10: [mem 0xfbbe0000-0xfbbe3fff 64bit=
]
[   12.650426] pci 0000:20:04.2: [8086:3c22] type 00 class 0x088000
[   12.652317] pci 0000: [mem 0xfbbd0000-0xfbbd3fff 64bit]
[   13.153441] pci 0000:20:04.3: [8086:3c23] type 00 class 0x088000
[   13.155318] pci 0000:20:04.3: reg 0x10: [mem 0xfbbc0000-0xfbbc3fff 64bit=
]
[   13.158427] pci 0000:20:04.4: [8086:3c24] type 00 class 0x088000
[   13.160317] pci 0000:20:04.4: reg 0x10: [mem 0xfbbb0000-0xfbbb3fff 64bit=
]
[   13.162426] pci 0000:20:04.5: [8086:3c25] type 00 class 0x088000
[   13.164317] pci 0000:20:04.5: reg 0x10: [mem 0xfbba0000-0xfbba3fff 64bit=
]
[   13.166426] pci 0000:20:04.6: [8086:3c26] type 00 class 0x088000
[   13.169317] pci 0000:20:04.6: reg 0x10: [mem 0xfbb90000-0xfbb93fff 64bit=
]
[   13.171425] pci 0000:20:04.7: [8086:3c27] type 00 class 0x088000
[   13.173317] pci 0000:20:04.7: reg 0x10: [mem 0xfbb80000-0xfbb83fff 64bit=
]
[   13.175417] pci 0000:20:05.0: [8086:3c28] type 00 class 0x088000
[   13.177420] pci 0000:20:05.2: [8086:3c2a] type 00 class 0x088000
[   13.179416] pci 0000:20:05.4: [8086:3c2c] type 00 class 0x080020
[   13.182313] pci 0000:20:05.4: reg 0x10: [mem 0xfbb70000-0xfbb70fff]
[   13.184444] pci 0000:20:00.0: PCI bridge to [bus 31]
[   13.186354] pci 0000:20:01.0: PCI bridge to [bus 2a]
[   1:20:01.1: PCI bridge to [bus 2b]
[   13.688570] pci 0000:20:02.0: PCI bridge to [bus 27]
[   13.690343] pci 0000:20:02.1: PCI bridge to [bus 2c]
[   13.691544] pci 0000:24:00.0: [8086:150e] type 00 class 0x020000
[   13.694316] pci 0000:24:00.0: reg 0x10: [mem 0xfbf80000-0xfbffffff]
[   13.696317] pci 0000:24:00.0: reg 0x1c: [mem 0xfbf70000-0xfbf73fff]
[   13.698317] pci 0000:24:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[   13.700352] pci 0000:24:00.0: PME# supported from D0 D3hot D3cold
[   13.702466] pci 0000:24:00.1: [8086:150e] type 00 class 0x020000
[   13.705316] pci 0000:24:00.1: reg 0x10: [mem 0xfbe80000-0xfbefffff]
[   13.707316] pci 0000:24:00.1: reg 0x1c: [mem 0xfbe70000-0xfbe73fff]
[   13.709367] pci 0000:24:00.1: PME# supported from D0 D3hot D3cold
[   13.711445] pci 0000:24:00.2: [8086:150e] type 00 class 0x020000
[   13.713315] pci 0000:24:00.2: reg 0x10: [mem 0xfbd80000-0xfbdfffff]
[   13.715316] pci 0000:24:00.2: reg 0x1c: [mem 0xfbd70000-0xfbd73fff]
[   13.717367] pci 0000:24:00.2: PME# supported from D0 D3hot D3cold
[   13.720437] pci 0000:24:00.3: [8086:150e] type 00 class 0x020000
[   13.722315] pci 0000:24:00.3: reg 0x10: [mem 0xfbc80000-0xfbcfffff]
[   13.724316] pci 0000:24:00.3: reg 0x1c: [mem 0xfbc70000-0xfb3.964376] pc=
i 0000:24:00.3: PME# supported from D0 D3hot D3cold
[   14.130329] pci 0000:20:02.2: PCI bridge to [bus 24]
[   14.132303] pci 0000:20:02.2:   bridge window [mem 0xfbc00000-0xfbffffff=
]
[   14.135341] pci 0000:20:02.3: PCI bridge to [bus 2d]
[   14.136539] pci 0000:20:03.0: PCI bridge to [bus 21]
[   14.138343] pci 0000:20:03.1: PCI bridge to [bus 2e]
[   14.140340] pci 0000:20:03.2: PCI bridge to [bus 2f]
[   14.142340] pci 0000:20:03.3: PCI bridge to [bus 30]
[   14.144618] iommu: Default domain type: Passthrough=20
[   14.146357] pci 0000:01:00.1: vgaarb: setting as boot VGA device
[   14.147297] pci 0000:01:00.1: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone
[   14.151316] pci 0000:01:00.1: vgaarb: bridge control possible
[   14.153300] vgaarb: loaded
[   14.154542] SCSI subsystem initialized
[   14.156350] ACPI: bus type USB registered
[   14.157332] usbcore: registered new interface driver usbfs
[   14.159314] usbcore: registered new interface driver hub
[   14.161455] usbcore: registered new device driver usb
[   14.163344] pps_core: LinuxPPS API ver. 1 registered
[   14.165300] pps_core: Software vght 2005-2007 Rodolfo Giometti <giometti=
@linux.it>
[   14.666321] PTP clock support registered
[   14.667384] EDAC MC: Ver: 3.0.0
[   14.669364] PCI: Using ACPI for IRQ routing
[   14.670649] PCI: Discovered peer bus 1f
[   14.672324] PCI host bridge to bus 0000:1f
[   14.673300] pci_bus 0000:1f: root bus resource [io  0x0000-0xffff]
[   14.675299] pci_bus 0000:1f: root bus resource [mem 0x00000000-0x3ffffff=
fffff]
[   14.678299] pci_bus 0000:1f: No busn resource found for root bus, will u=
se [bus 1f-ff]
[   14.680300] pci_bus 0000:1f: busn_res: can not insert [bus 1f-ff] under =
domain [bus 00-ff] (conflicts with (null) [bus 00-1f])
[   14.684308] pci 0000:1f:08.0: [8086:3c80] type 00 class 0x088000
[   14.686366] pci 0000:1f:08.3: [8086:3c83] type 00 class 0x088000
[   14.688369] pci 0000:1f:08.4: [8086:3c84] type 00 class 0x088000
[   14.690378] pci 0000:1f:09.0: [8086:3c90] type 00 class 0x088000
[   14.693359] pci 0000:1f:09.3: [8086:3c93] type 00 class 0x088000
[   14.695370] pci 0000:1f:09.4: [8086:3c94] type 00 class 0x088000
[   14.697377] pci 0000:1f:0a.0: [8086:3cc0] type 00 class 0x088000
[   14.699345] pci 0000:1f:0a.1: [8086:3cc1] type 00 class 0x088000
[   14.701353] pci 0000:1f:0a.2: [8086:3cc2] type 00 class 0x088000
[   14.703344] pci 0000:1f:0a.3: [8086:3cd0] type 00 class 0x088000
[   14.705352] pci 0000:1f:0b.0: [8086:3ce0] type 00 class 0x088000
[ 000:1f:0b.3: [8086:3ce3] type 00 class 0x088000
[   15.208346] pci 0000:1f:0c.0: [8086:3ce8] type 00 class 0x088000
[   15.210404] pci 0000:1f:0c.1: [8086:3ce8] type 00 class 0x088000
[   15.212395] pci 0000:1f:0c.2: [8086:3ce8] type 00 class 0x088000
[   15.214388] pci 0000:1f:0c.6: [8086:3cf4] type 00 class 0x088000
[   15.216393] pci 0000:1f:0c.7: [8086:3cf6] type 00 class 0x088000
[   15.219384] pci 0000:1f:0d.0: [8086:3ce8] type 00 class 0x088000
[   15.221392] pci 0000:1f:0d.1: [8086:3ce8] type 00 class 0x088000
[   15.223385] pci 0000:1f:0d.2: [8086:3ce8] type 00 class 0x088000
[   15.225397] pci 0000:1f:0d.6: [8086:3cf5] type 00 class 0x088000
[   15.227386] pci 0000:1f:0e.0: [8086:3ca0] type 00 class 0x088000
[   15.230404] pci 0000:1f:0e.1: [8086:3c46] type 00 class 0x110100
[   15.232401] pci 0000:1f:0f.0: [8086:3ca8] type 00 class 0x088000
[   15.234430] pci 0000:1f:0f.1: [8086:3c71] type 00 class 0x088000
[   15.236425] pci 0000:1f:0f.2: [8086:3caa] type 00 class 0x088000
[   15.238415] pci 0000:1f:0f.3: [8086:3cab] type 00 class 0x088000
[   15.240421] pci 0000:1f:0f.4: [e 00 class 0x088000
[   15.641382] pci 0000:1f:0f.5: [8086:3cad] type 00 class 0x088000
[   15.644368] pci 0000:1f:0f.6: [8086:3cae] type 00 class 0x088000
[   15.646351] pci 0000:1f:10.0: [8086:3cb0] type 00 class 0x088000
[   15.648371] pci 0000:1f:10.1: [8086:3cb1] type 00 class 0x088000
[   15.650368] pci 0000:1f:10.2: [8086:3cb2] type 00 class 0x088000
[   15.652361] pci 0000:1f:10.3: [8086:3cb3] type 00 class 0x088000
[   15.654368] pci 0000:1f:10.4: [8086:3cb4] type 00 class 0x088000
[   15.657362] pci 0000:1f:10.5: [8086:3cb5] type 00 class 0x088000
[   15.659370] pci 0000:1f:10.6: [8086:3cb6] type 00 class 0x088000
[   15.661368] pci 0000:1f:10.7: [8086:3cb7] type 00 class 0x088000
[   15.663360] pci 0000:1f:11.0: [8086:3cb8] type 00 class 0x088000
[   15.665359] pci 0000:1f:13.0: [8086:3ce4] type 00 class 0x088000
[   15.667345] pci 0000:1f:13.1: [8086:3c43] type 00 class 0x110100
[   15.669353] pci 0000:1f:13.4: [8086:3ce6] type 00 class 0x110100
[   15.671343] pci 0000:1f:13.5: [8086:3c44] type 00 class 0x110100
[   15.673346] pci 0000:1f:13.6: [8086:3c45] type 00 class 0x088000
[   15.675353] pci_bus 0000:1f: busn_res: [bpdated to 1f
[   16.177316] pci_bus 0000:1f: busn_res: can not insert [bus 1f] under dom=
ain [bus 00-ff] (conflicts with (null) [bus 00-1f])
[   16.180733] PCI: Discovered peer bus 3f
[   16.182355] PCI host bridge to bus 0000:3f
[   16.184303] pci_bus 0000:3f: root bus resource [io  0x0000-0xffff]
[   16.186303] pci_bus 0000:3f: root bus resource [mem 0x00000000-0x3ffffff=
fffff]
[   16.188301] pci_bus 0000:3f: No busn resource found for root bus, will u=
se [bus 3f-ff]
[   16.191303] pci_bus 0000:3f: busn_res: can not insert [bus 3f-ff] under =
domain [bus 00-ff] (conflicts with (null) [bus 20-3f])
[   16.195317] pci 0000:3f:08.0: [8086:3c80] type 00 class 0x088000
[   16.197406] pci 0000:3f:08.3: [8086:3c83] type 00 class 0x088000
[   16.199430] pci 0000:3f:08.4: [8086:3c84] type 00 class 0x088000
[   16.202437] pci 0000:3f:09.0: [8086:3c90] type 00 class 0x088000
[   16.204400] pci 0000:3f:09.3: [8086:3c93] type 00 class 0x088000
[   16.206432] pci 0000:3f:09.4: [8086:3c94] type 00 class 0x088000
[   16.208425] pci 0000:3f:0a.0: [8086:3cc0] type 00 class 0x088000
[   16.211398] pci 0000:3f:0a.1: [8086:3cc1] type 00 class 0x088000
[   16.213386] pci 0000:3f:0a.2: [8086:3cc2] type 00 class 0x088000
[   16.215396] pci 0000:3f:0a.3: [8086:3cd0] typ0
[   16.715382] pci 0000:3f:0b.0: [8086:3ce0] type 00 class 0x088000
[   16.717355] pci 0000:3f:0b.3: [8086:3ce3] type 00 class 0x088000
[   16.720350] pci 0000:3f:0c.0: [8086:3ce8] type 00 class 0x088000
[   16.722358] pci 0000:3f:0c.1: [8086:3ce8] type 00 class 0x088000
[   16.724356] pci 0000:3f:0c.2: [8086:3ce8] type 00 class 0x088000
[   16.726350] pci 0000:3f:0c.6: [8086:3cf4] type 00 class 0x088000
[   16.728350] pci 0000:3f:0c.7: [8086:3cf6] type 00 class 0x088000
[   16.730347] pci 0000:3f:0d.0: [8086:3ce8] type 00 class 0x088000
[   16.732350] pci 0000:3f:0d.1: [8086:3ce8] type 00 class 0x088000
[   16.734348] pci 0000:3f:0d.2: [8086:3ce8] type 00 class 0x088000
[   16.736352] pci 0000:3f:0d.6: [8086:3cf5] type 00 class 0x088000
[   16.738348] pci 0000:3f:0e.0: [8086:3ca0] type 00 class 0x088000
[   16.741357] pci 0000:3f:0e.1: [8086:3c46] type 00 class 0x110100
[   16.743360] pci 0000:3f:0f.0: [8086:3ca8] type 00 class 0x088000
[   16.745378] pci 0000:3f:0f.1: [8086:3c71] type 00 class 0x088000
[   16.747377] pci 0000:3f:0f.2: [8086:3caa] type 00 class 0x088000
[   16.749371] pci 0000:3f:0f.3: [8086:3cab] type 00 class 0x088000
[   16.751377] pci 0000:3f:0f.4: [8086:3cac] type 00 class 0x088000
[    0000:3f:0f.5: [8086:3cad] type 00 class 0x088000
[   17.155385] pci 0000:3f:0f.6: [8086:3cae] type 00 class 0x088000
[   17.157351] pci 0000:3f:10.0: [8086:3cb0] type 00 class 0x088000
[   17.159372] pci 0000:3f:10.1: [8086:3cb1] type 00 class 0x088000
[   17.161371] pci 0000:3f:10.2: [8086:3cb2] type 00 class 0x088000
[   17.163365] pci 0000:3f:10.3: [8086:3cb3] type 00 class 0x088000
[   17.165371] pci 0000:3f:10.4: [8086:3cb4] type 00 class 0x088000
[   17.167366] pci 0000:3f:10.5: [8086:3cb5] type 00 class 0x088000
[   17.169373] pci 0000:3f:10.6: [8086:3cb6] type 00 class 0x088000
[   17.171368] pci 0000:3f:10.7: [8086:3cb7] type 00 class 0x088000
[   17.174363] pci 0000:3f:11.0: [8086:3cb8] type 00 class 0x088000
[   17.176356] pci 0000:3f:13.0: [8086:3ce4] type 00 class 0x088000
   17.206353] pci 0000:3f:13.4: [8086:3ce6] type 00 class 0x1101000
[   17.281347] pci 0000:3f:13.5: [8086:3c44] type 00 class 0x110100
[   17.284348] pci 0000:3f:13.6: [8086:3c45] type 00 class 0x088000
[   17.286353] pci_bus 0000:3f: busn_res: [bus 3f-ff] end is updated to 3f
[   17.288300] pci_bus 0000:3f: busn_res: can not insert [bus 3f] under dom=
ain [bus 00-ff] (conflicts with (null) [bus 20-3f])
[   17.297541] NetLabel: Initializing
[  Label:  domain hash size =3D 128
[   17.699311] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[   17.701324] NetLabel:  unlabeled traffic allowed by default
[   17.703364] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[   17.705300] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[   17.709376] clocksource: Switched to clocksource tsc-early
[   17.729217] VFS: Disk quotas dquot_6.6.0
[   17.730978] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[   17.733600] pnp: PnP ACPI init
[   17.735324] system 00:00: [mem 0xf4ffe000-0xf4ffffff] could not be reser=
ved
[   17.738116] system 00:01: [io  0x0408-0x040f] has been reserved
[   17.740343] system 00:01: [io  0x04d0-0x04d1] has been reserved
[   17.742406] system 00:01: [io  0x0310-0x0315] has been reserved
[   17.744391] system 00:01: [io  0x0316-0x0317] has been reserved
[   17.746356] system 00:01: [io  0x0700-0x071f] has been reserved
[   17.748326] system 00:01: [io  0x0880-0x08ff] has been reserved
[   17.750291] system 00:01: [io  0x0900-0x097f] has been reserved
[   17.752338] system 00:01: [io  0x0cd4-0x0cd7] has been reserved
[   17.754449] system 00:01: [io  0x0cd0-0x0cd3] has been reserved
[   17.756423] system 00:01: [io  0x0f50-0x0f58] has been reserved
[   17.758447] system 00:01: [io  0x0ca0-0x0ca1] has been reserved
[   17.760415] system 00:01: [io  0x0ca4-0x0ca5] has been reserved
[   17.762680] system 00:01: [io  0x02f8-0x02ff] has been reserved
[   17.764663] system 00:01: [mefffff] has been reserved
[   18.266896] system 00:01: [mem 0xfe000000-0xfebfffff] has been reserved
[   18.269096] system 00:01: [mem 0xfc000000-0xfc000fff] has been reserved
[   18.271394] system 00:01: [mem 0xfed1c000-0xfed1ffff] has been reserved
[   18.273559] system 00:01: [mem 0xfed30000-0xfed3ffff] has been reserved
[   18.275722] system 00:01: [mem 0xfee00000-0xfee00fff] has been reserved
[   18.277869] system 00:01: [mem 0xff800000-0xffffffff] has been reserved
[   18.280573] system 00:06: [mem 0xfbafe000-0xfbafffff] could not be reser=
ved
[   18.282988] pnp: PnP ACPI: found 7 devices
[   18.286542] thermal_sys: Registered thermal governor 'fair_share'
[   18.286543] thermal_sys: Registered thermal governor 'step_wise'
[   18.288701] thermal_sys: Registered thermal governor 'user_space'
[   18.295364] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[   18.300542] pci 0000:00:02.0: BAR 14: assigned [mem 0xf4000000-0xf40ffff=
f]
[   18.302889] pci 0000:00:01.0: PCI bridge to [bus 08]
[   18.304546] pci 0000:00:01.1: PCI bridge to [bus 14]
[   18.306212] pci 0000:03:00.0: BAR 6: assigned [mem 0xf4000000-0xf403ffff=
 pref]
[   18.308572] pci 0000:03:00.1: BAR 6: assigned [mem 0xf4040000-0xf407ffff=
 pref]
[   18.311044] pci 0000:03:00.2: BAR 6: assigned [mem 0xf4080000-0xf40bffff=
 pref]
[   18.313437] pci 0000:03:00.3: BAR 6: assigned [mem 0xf40c0000-0xf40fffff=
 pref]
[   18.315877] pci 0000:00:02.0: PCI bridge t8.637415] pci 0000:00:02.0:   =
bridge window [mem 0xf4000000-0xf40fffff]
[   18.819939] pci 0000:00:02.0:   bridge window [mem 0xf6b00000-0xf6bfffff=
 64bit pref]
[   18.822597] pci 0000:00:02.1: PCI bridge to [bus 15]
[   18.824274] pci 0000:02:00.0: BAR 6: assigned [mem 0xf7c00000-0xf7c7ffff=
 pref]
[   18.826642] pci 0000:00:02.2: PCI bridge to [bus 02]
[   18.828303] pci 0000:00:02.2:   bridge window [io  0x5000-0x5fff]
[   18.830315] pci 0000:00:02.2:   bridge window [mem 0xf7c00000-0xf7dfffff=
]
[   18.832578] pci 0000:00:02.3: PCI bridge to [bus 16]
[   18.834202] pci 0000:06:00.0: BAR 6: assigned [mem 0xf7e00000-0xf7e1ffff=
 pref]
[   18.836586] pci 0000:06:00.1: BAR 6: assigned [mem 0xf7e20000-0xf7e3ffff=
 pref]
[   18.838980] pci 0000:05:02.0: PCI bridge to [bus 06]
[   18.840646] pci 0000:05:02.0:   bridge window [io  0x6000-0x6fff]
[   18.842730] pci 0000:05:02.0:   bridge window [mem 0xf7e00000-0xf7efffff=
]
[   18.844977] pci 0000:07:00.0: BAR 6: assigned [mem 0xf7f00000-0xf7f1ffff=
 pref]
[   18.847335] pci 0000:07:00.1: BAR 6: assigned [mem 0xf7f20000-0xf7f3ffff=
 pref]
[   18.849731] pci 0000:05:04.0: PCI bridge to [bus 07]
[   18.851439] pci 0000:05:04.0:   bridge window [io  0x7000-0x7fff]
[   18.853454] pci 0000:05:04.0:   bridge window [mem 0xf7f00000-0xf7ffffff=
]
[   18.855722] pci 0000ridge to [bus 05-07]
[   19.257355] pci 0000:04:00.0:   bridge window [io  0x6000-0x7fff]
[   19.259407] pci 0000:04:00.0:   bridge window [mem 0xf7e00000-0xfffff]
[   19.361806] pci 0000:00:03.0: PCI bridge to [bus 04-07]
[   19.363575] pci 0000:00:03.0:   bridge window [io  0x6000-0x7fff]
[   19.365617] pci 0000:00:03.0:   bridge window [mem 0xf7e00000-0xf7ffffff=
]
[   19.367898] pci 0000:00:03.1: PCI bridge to [bus 17]
[   19.369544] pci 0000:00:03.2: PCI bridge to [bus 18]
[   19.371306] pci 0000:00:03.3: PCI bridge to [bus 19]
[   19.373128] pci 0000:00:11.0: PCI bridge to [bus 1b]
[   19.374804] pci 0000:00:1c.0: PCI bridge to [bus 0b]
[   19.376468] pci 0000:01:00.2: BAR 6: assigned [mem 0xf6d00000-0xf6d0ffff=
 pref]
[   19.378869] pci 0000:00:1c.7: PCI bridge to [bus 01]
[   19.380511] pci 0000:00:1c.7:   bridge window [io  0x3000-0x3fff]
[   19.382621] pci 0000:00:1c.7:   bridge window [mem 0xf6d00000-0xf7bfffff=
]
[   19.384886] pci 0000:00:1c.7:   bridge window [mem 0xf5000000-0xf5ffffff=
 64bit pref]
[   19.387448] pci 0000:00:1e.0: PCI bridge to [bus 1a]
[   19.389126] pci_bus 0000:00: resource 4 [mem 0xf4000000-0xf7ffffff windo=
w]
[   19.391497] pci_bus 0000:00: resource 5 [io  0x1000-0x7fff window]
[   19.393702] pci_bus 0000:00: resource 6 [io  0x0000-0x03af window]
[   19.395793] pci_bus 0000:00: resource 7 [io  0x03e0-0x0cf7 window]
[   19.397855] pci_bus 0000:00: resource 8 [io  0x0dow]
[   19.799842] pci_bus 0000:00: resource 9 [io  0x03b0-0x03bb window]
[   19.801989] pci_bus 0000:00: resource 10 [io  0x03c0-0x03df window]
[   19.804086] pci_bus 0000:00: resource 11 [mem 0x000a0000-0x000bffff wind=
ow]
[   19.806402] pci_bus 0000:03: resource 1 [mem 0xf4000000-0xf40fffff]
[   19.808484] pci_bus 0000:03: resource 2 [mem 0xf6b00000-0xf6bfffff 64bit=
 pref]
[   19.810973] pci_bus 0000:02: resource 0 [io  0x5000-0x5fff]
[   19.812839] pci_bus 0000:02: resource 1 [mem 0xf7c00000-0xf7dfffff]
[   19.814923] pci_bus 0000:04: resource 0 [io  0x6000-0x7fff]
[   19.816775] pci_bus 0000:04: resource 1 [mem 0xf7e00000-0xf7ffffff]
[   19.819253] pci_bus 0000:05: resource 0 [io  0x6000-0x7fff]
[   19.821204] pci_bus 0000:05: resource 1 [mem 0xf7e00000-0xf7ffffff]
[   19.823295] pci_bus 0000:06: resource 0 [io  0x6000-0x6fff]
[   19.825155] pci_bus 0000:06: resource 1 [mem 0xf7e00000-0xf7efffff]
[   19.827238] pci_bus 0000:07: resource 0 [io  0x7000-0x7fff]
[   19.829088] pci_bus 0000:07: resource 1 [mem 0xf7f00000-0xf7ffffff]
[   19.831228] pci_bus 0000:01: resource 0 [io  0x3000-0x3fff]
[   19.833094] pci_bus 0000:01: resource 1 [mem 0xf6d00000-0xf7bfffff]
[   19.835160] pci_bus 0000:01: resource 2 [mem 0xf5000000-0xf5ffffff 64bit=
 pref]
[   19.837544] pci_bus 0000:1a: resource 4 [memffff window]
[   20.339881] pci_bus 0000:1a: resource 5 [io  0x1000-0x7fff window]
[   20.342032] pci_bus 0000:1a: resource 6 [io  0x0000-0x03af window]
[   20.344092] pci_bus 0000:1a: resource 7 [io  0x03e0-0x0cf7 window]
[   20.346161] pci_bus 0000:1a: resource 8 [io  0x0d00-0x0fff window]
[   20.348216] pci_bus 0000:1a: resource 9 [io  0x03b0-0x03bb window]
[   20.350263] pci_bus 0000:1a: resource 10 [io  0x03c0-0x03df window]
[   20.352441] pci_bus 0000:1a: resource 11 [mem 0x000a0000-0x000bffff wind=
ow]
[   20.354789] pci 0000:20:00.0: PCI bridge to [bus 31]
[   20.356429] pci 0000:20:01.0: PCI bridge to [bus 2a]
[   20.358097] pci 0000:20:01.1: PCI bridge to [bus 2b]
[   20.359730] pci 0000:20:02.0: PCI bridge to [bus 27]
[   20.361478] pci 0000:20:02.1: PCI bridge to [bus 2c]
[   20.363145] pci 0000:24:00.0: BAR 6: no space for [mem size 0x00080000 p=
ref]
[   20.365454] pci 0000:24:00.0: BAR 6: failed to assign [mem size 0x000800=
00 pref]
[   20.367913] pci 0000:20:02.2: PCI bridge to [bus 24]
[   20.369552] pci 0000:20:02.2:   bridge window [mem 0xfbc00000-0xfbffffff=
]
[   20.371906] pci 0000:20:02.3: PCI bridge to [bus 2d]
[   20.373547] pci 0000:20:03.0: PCI bridge to [bus 21]
[   20.375215] pci 0000:20:0 [bus 2e]
[   20.876705] pci 0000:20:03.2: PCI bridge to [bus 2f]
[   20.878386] pci 0000:20:03.3: PCI bridge to [bus 30]
[   20.880085] pci_bus 0000:20: resource 4 [mem 0xf8000000-0xfbffffff windo=
w]
[   20.882435] pci_bus 0000:20: resource 5 [io  0x8000-0xffff window]
[   20.884509] pci_bus 0000:24: resource 1 [mem 0xfbc00000-0xfbffffff]
[   20.886649] pci_bus 0000:1f: resource 4 [io  0x0000-0xffff]
[   20.888533] pci_bus 0000:1f: resource 5 [mem 0x00000000-0x3fffffffffff]
[   20.890763] pci_bus 0000:3f: resource 4 [io  0x0000-0xffff]
[   20.892658] pci_bus 0000:3f: resource 5 [mem 0x00000000-0x3fffffffffff]
[   20.895045] NET: Registered protocol family 2
[   20.897388] tcp_listen_portaddr_hash hash table entries: 32768 (order: 7=
, 524288 bytes, vmalloc)
[   20.900812] TCP established hash table entries: 524288 (order: 10, 41943=
04 bytes, vmalloc)
[   20.905111] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes,=
 vmalloc)
[   20.907840] TCP: Hash tables configured (established 524288 bind 65536)
[   20.910523] UDP hash table entries: 32768 (order: 8, 1048576 bytes, vmal=
loc)
[   20.913415] UDP-Lite hash table entries: 32768 (order: 8, 1048576 bytes,=
 vmalloc)
[   20.916705] NET: Registered protocol family 1
[   20.918202] NET: Registfamily 44
[   21.332516] pci 0000:00:1a.0: quirk_usb_early_handoff+0x0/0x646 took 125=
25 usecs
[   21.347493] pci 0000:00:1d.0: quirk_usb_early_handoff+0x0/0x646 took 121=
22 usecs
[   21.350087] pci 0000:01:00.1: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[   21.353697] PCI: CLS 64 bytes, default 64
[   21.355187] Trying to unpack rootfs image as initramfs...
[   21.961948] Freeing initrd memory: 27624K
[   21.964834] DMAR: dmar0: Using Queued invalidation
[   21.966527] DMAR: dmar1: Using Queued invalidation
[   21.969477] pci 0000:00:00.0: Adding to iommu group 0
[   21.971390] pci 0000:00:01.0: Adding to iommu group 1
[   21.973173] pci 0000:00:01.1: Adding to iommu group 2
[   21.974930] pci 0000:00:02.0: Adding to iommu group 3
[   21.976672] pci 0000:00:02.1: Adding to iommu group 4
[   21.978446] pci 0000:00:02.2: Adding to iommu group 5
[   21.980224] pci 0000:00:02.3: Adding to iommu group 6
[   21.982096] pci 0000:00:03.0: Adding to iommu group 7
[   21.983868] pci 0000:00:03.1: Adding to iommu group 8
[   21.985644] pci 0000:00:03.2: Adding to iommu group 9
[   21.987484] pci 0000:00:03.3: Adding to iommu group 10
[   21.989830] pci 0000:00:04.0: Adding to iommu group 11
[   21.991738] pci 0000:00:04.1: Adding to iommu group 11
[   21.993557] pci 0000:00:04.2: Adding to iommu group 11
[   21.995360] pci 0000:00:04.3: Adding to iommu group 11
[   21.997145] pci 0000:00:04.4: Adding to iommu group 11
[   21.998915] pci 0000:00:04.5: Adding to iommu group 11
[   22.000694] pci 0000:00:04.6: Adding to iommu group 11
[   22.002569] pci 0000:00:04.7: Adding to iommu group 11
[   22.004556] pci 0000:00:05.0: Adding to iommu group 12
[   22.006388] pci 0000:00:05.2: Adding to iommu group 12
[   22.008186] pci 0000:00:05.4: Adding to iommu group 12
[   22.009968] pci 0000:00:11.0: Adding to iommu group 13
[   22.011815] pci 0000:00:1a.0: Adding to iommu group 14
[   22.013605] pci 0000:00:1c.0: Adding to iommu group 15
[   22.015408] pci 0000:00:1c.7: Adding to iommu group 16
[   22.017216] pci 0000:00:1d.0: Adding to iommu group 17
[   22.018991] pci 0000:00:1e.0: Adding to iommu group 18
[   22.021826] pci 0000:00:1e.0: Using iommu dma mapping
[   22.023783] pci 0000:00:1f.0: Adding to iommu group 19
[   22.025667] pci 0000:00:1f.2: Adding to iommu group 19
[   22.028569] pci 0000:00:1f.2: DMAR: Setting identity map- 0xe8fff]
[   22.331183] pci 0000:00:1f.2: DMAR: Setting identity map [0xf4000 - 0xf4=
fff]
[   22.333546] pci 0000:00:1f.2: DMAR: Setting identity map [0xbdf6e000 - 0=
xbdf6efff]
[   22.336099] pci 0000:00:1f.2: DMAR: Setting identity map [0xbdf6f000 - 0=
xbdf7efff]
[   22.338604] pci 0000:00:1f.2: DMAR: Setting identity map [0xbdf7f000 - 0=
xbdf82fff]
[   22.341189] pci 0000:00:1f.2: DMAR: Setting identity map [0xbdf83000 - 0=
xbdf84fff]
[   22.343700] pci 0000:00:1f.2: DMAR: Device uses a private dma domain.
[   22.346001] pci 0000:03:00.0: Adding to iommu group 20
[   22.348727] pci 0000:03:00.0: Using iommu dma mapping
[   22.350644] pci 0000:03:00.1: Adding to iommu group 20
[   22.352833] pci 0000:03:00.2: Adding to iommu group 20
[   22.354619] pci 0000:03:00.3: Adding to iommu group 20
[   22.356423] pci 0000:02:00.0: Adding to iommu group 21
[   22.358999] pci 0000:02:00.0: Using iommu dma mapping
[   22.360785] pci 0000:04:00.0: Adding to iommu group 22
[   22.362623] pci 0000:05:02.0: Adding to iommu group 23
[   22.364412] pci 0000:05:04.0: Adding to iommu group 24
[   22.366172] pci 0000:06:00.0: Adding to iommu group 23
[   22.368762] pci 0000:06:00.0: DMAR: Setting identity map [0xe8000 - 0xe8=
fff]
[   22.371290] pci 0000:06:00.0: DMAR: Setting identity map [0xf4000 - 0xf4=
fff]
[   22.373646] pci 0000:06:00.0: DMAR: Setting ide000 - 0xbdf6efff]
[   22.876042] pci 0000:06:00.0: DMAR: Setting identity map [0xbdf6f000 - 0=
xbdf7efff]
[   22.878572] pci 0000:06:00.0: DMAR: Setting identity map [0xbdf7f000 - 0=
xbdf82fff]
[   22.881167] pci 0000:06:00.0: DMAR: Setting identity map [0xbdf83000 - 0=
xbdf84fff]
[   22.883729] pci 0000:06:00.0: DMAR: Device uses a private dma domain.
[   22.885899] pci 0000:06:00.1: Adding to iommu group 23
[   22.888675] pci 0000:06:00.1: DMAR: Setting identity map [0xe8000 - 0xe8=
fff]
[   22.891216] pci 0000:06:00.1: DMAR: Setting identity map [0xf4000 - 0xf4=
fff]
[   22.893576] pci 0000:06:00.1: DMAR: Setting identity map [0xbdf6e000 - 0=
xbdf6efff]
[   22.896119] pci 0000:06:00.1: DMAR: Setting identity map [0xbdf6f000 - 0=
xbdf7efff]
[   22.898620] pci 0000:06:00.1: DMAR: Setting identity map [0xbdf7f000 - 0=
xbdf82fff]
[   22.901232] pci 0000:06:00.1: DMAR: Setting identity map [0xbdf83000 - 0=
xbdf84fff]
[   22.903736] pci 0000:06:00.1: DMAR: Device uses a private dma domain.
[   22.905906] pci 0000:07:00.0: Adding to iommu group 24
[   22.908705] pci 0000:07:00.0: DMAR: Setting identity map [0xe8000 - 0xe8=
fff]
[   22.911149] pci 0000:07:00.0: DMAR: Setting identity map [0xf4000 - 0xf4=
fff]
[   22.913483] pci 0000:07:00.0: DMAR: Setting identity map [0xbdf6e000 - 0=
xbdf6efff]
[   22.9100.0: DMAR: Setting identity map [0xbdf6f000 - 0xbdf7efff]
[   23.418361] pci 0000:07:00.0: DMAR: Setting identity map [0xbdf7f000 - 0=
xbdf82fff]
[   23.420922] pci 0000:07:00.0: DMAR: Setting identity map [0xbdf83000 - 0=
xbdf84fff]
[   23.423506] pci 0000:07:00.0: DMAR: Device uses a private dma domain.
[   23.425680] pci 0000:07:00.1: Adding to iommu group 24
[   23.428513] pci 0000:07:00.1: DMAR: Setting identity map [0xe8000 - 0xe8=
fff]
[   23.430910] pci 0000:07:00.1: DMAR: Setting identity map [0xf4000 - 0xf4=
fff]
[   23.433253] pci 0000:07:00.1: DMAR: Setting identity map [0xbdf6e000 - 0=
xbdf6efff]
[   23.435794] pci 0000:07:00.1: DMAR: Setting identity map [0xbdf6f000 - 0=
xbdf7efff]
[   23.438329] pci 0000:07:00.1: DMAR: Setting identity map [0xbdf7f000 - 0=
xbdf82fff]
[   23.440806] pci 0000:07:00.1: DMAR: Setting identity map [0xbdf83000 - 0=
xbdf84fff]
[   23.443733] pci 0000:07:00.1: DMAR: Device uses a private dma domain.
[   23.446201] pci 0000:01:00.0: Adding to iommu group 25
[   23.448949] pci 0000:01:00.0: Using iommu dma mapping
[   23.450807] pci 0000:01:00.1: Adding to iommu group 25
[   23.452666] pci 0000:01:00.1: DMAR: Device uses a private identity domai=
n.
[   23.455063] pci 0000:01:00.2: Adding to iommu group 25
[   23.456881] pci 0000:01:00.4: Adding to iommu group 25
[   23.458693] pci 0000:01:00.4: DMAR: Device uses a private identity domai=
n.
[   20000:20:00.0: Adding to iommu group 26
[   23.863235] pci 0000:20:01.0: Adding to iommu group 27
[   23.864997] pci 0000:20:01.1: Adding to iommu group 28
[   23.866787] pci 0000:20:02.0: Adding to iommu group 29
[   23.868564] pci 0000:20:02.1: Adding to iommu group 30
[   23.870356] pci 0000:20:02.2: Adding to iommu group 31
[   23.872220] pci 0000:20:02.3: Adding to iommu group 32
[   23.874108] pci 0000:20:03.0: Adding to iommu group 33
[   23.875874] pci 0000:20:03.1: Adding to iommu group 34
[   23.877645] pci 0000:20:03.2: Adding to iommu group 35
[   23.879420] pci 0000:20:03.3: Adding to iommu group 36
[   23.881489] pci 0000:20:04.0: Adding to iommu group 37
[   23.883311] pci 0000:20:04.1: Adding to iommu group 37
[   23.885099] pci 0000:20:04.2: Adding to iommu group 37
[   23.886864] pci 0000:20:04.3: Adding to iommu group 37
[   23.888666] pci 0000:20:04.4: Adding to iommu group 37
[   23.890448] pci 0000:20:04.5: Adding to iommu group 37
[   23.892312] pci 0000:20:04.6: Adding to iommu group 37
[   23.894083] pci 0000:20:04.7: Adding to iommu group 37
[   23.895908] pci 0000:20:05.0: Adding to iommu group 38
[   23.897716] pci 0000:20:05.2: Adding to iommu group 38
[   23.899485] pci 0000:20:05.4: Adding to iommu group 38
 0000:24:00.0: Adding to iommu group 39
[   24.403648] pci 0000:24:00.0: Using iommu dma mapping
[   24.405409] pci 0000:24:00.1: Adding to iommu group 40
[   24.407944] pci 0000:24:00.1: Using iommu dma mapping
[   24.409766] pci 0000:24:00.2: Adding to iommu group 41
[   24.412328] pci 0000:24:00.2: Using iommu dma mapping
[   24.414090] pci 0000:24:00.3: Adding to iommu group 42
[   24.416661] pci 0000:24:00.3: Using iommu dma mapping
[   24.418508] pci 0000:1f:08.0: Adding to iommu group 43
[   24.420275] pci 0000:1f:08.3: Adding to iommu group 43
[   24.422094] pci 0000:1f:08.4: Adding to iommu group 43
[   24.423909] pci 0000:1f:09.0: Adding to iommu group 44
[   24.425662] pci 0000:1f:09.3: Adding to iommu group 44
[   24.427422] pci 0000:1f:09.4: Adding to iommu group 44
[   24.429261] pci 0000:1f:0a.0: Adding to iommu group 45
[   24.431027] pci 0000:1f:0a.1: Adding to iommu group 45
[   24.432807] pci 0000:1f:0a.2: Adding to iommu group 45
[   24.434570] pci 0000:1f:0a.3: Adding to iommu group 45
[   24.436381] pci 0000:1f:0b.0: Adding to iommu 703489] pci 0000:1f:0b.3: =
Adding to iommu group 46
[   24.939961] pci 0000:1f:0c.0: Adding to iommu group 47
[   24.941867] pci 0000:1f:0c.1: Adding to iommu group 47
[   24.943993] pci 0000:1f:0c.2: Adding to iommu group 47
[   24.945768] pci 0000:1f:0c.6: Adding to iommu group 47
[   24.947541] pci 0000:1f:0c.7: Adding to iommu group 47
[   24.949401] pci 0000:1f:0d.0: Adding to iommu group 48
[   24.951231] pci 0000:1f:0d.1: Adding to iommu group 48
[   24.952980] pci 0000:1f:0d.2: Adding to iommu group 48
[   24.954754] pci 0000:1f:0d.6: Adding to iommu group 48
[   24.956551] pci 0000:1f:0e.0: Adding to iommu group 49
[   24.958336] pci 0000:1f:0e.1: Adding to iommu group 49
[   24.960261] pci 0000:1f:0f.0: Adding to iommu group 50
[   24.962081] pci 0000:1f:0f.1: Adding to iommu group 50
[   24.963851] pci 0000:1f:0f.2: Adding to iommu group 50
[   24.965614] pci 0000:1f:0f.3: Adding to iommu group 50
[   24.967385] pci 0000:1f:0f.4: Adding to iommu group 50
[   24.969123] pci 0000:1f:0f.5: Adding to iommu group 50
[   24.970869] pci 0000:1f:0f.6: Adding to iommu group 50
[   24.972896] pci 0000:1f:10.0: Adding to iommu group 51
[   24.974675] pci 0000:1f:10.1: Adding to iommu group 51
[   24.976455] pci 0000:1f:10.2: Adding to iom[   25.326604] pci 0000:1f:10=
.3: Adding to iommu group 51
[   25.380003] pci 0000:1f:10.4: Adding to iommu group 51
[   25.381891] pci 0000:1f:10.5: Adding to iommu group 51
[   25.383686] pci 0000:1f:10.6: Adding to iommu group 51
[   25.385482] pci 0000:1f:10.7: Adding to iommu group 51
[   25.387300] pci 0000:1f:11.0: Adding to iommu group 52
[   25.389312] pci 0000:1f:13.0: Adding to iommu group 53
[   25.391349] pci 0000:1f:13.1: Adding to iommu group 53
[   25.393129] pci 0000:1f:13.4: Adding to iommu group 53
[   25.394894] pci 0000:1f:13.5: Adding to iommu group 53
[   25.396686] pci 0000:1f:13.6: Adding to iommu group 53
[   25.398528] pci 0000:3f:08.0: Adding to iommu group 54
[   25.400352] pci 0000:3f:08.3: Adding to iommu group 54
[   25.402221] pci 0000:3f:08.4: Adding to iommu group 54
[   25.404066] pci 0000:3f:09.0: Adding to iommu group 55
[   25.405879] pci 0000:3f:09.3: Adding to iommu group 55
[   25.407674] pci 0000:3f:09.4: Adding to iommu group 55
[   25.409562] pci 0000:3f:0a.0: Adding to iommu group 56
[   25.411460] pci 0000:3f:0a.1: Adding to iommu group 56
[   25.413273] pci 0000:3f:0a.2: Adding to iommu group 56
[   25.415047] pci 0000:3f:0a.3: Adding to iommu group 56
[   25.416b.0: Adding to iommu group 57
[   25.918495] pci 0000:3f:0b.3: Adding to iommu group 57
[   25.920362] pci 0000:3f:0c.0: Adding to iommu group 58
[   25.922191] pci 0000:3f:0c.1: Adding to iommu group 58
[   25.923959] pci 0000:3f:0c.2: Adding to iommu group 58
[   25.925736] pci 0000:3f:0c.6: Adding to iommu group 58
[   25.927515] pci 0000:3f:0c.7: Adding to iommu group 58
[   25.929366] pci 0000:3f:0d.0: Adding to iommu group 59
[   25.931135] pci 0000:3f:0d.1: Adding to iommu group 59
[   25.932904] pci 0000:3f:0d.2: Adding to iommu group 59
[   25.934675] pci 0000:3f:0d.6: Adding to iommu group 59
[   25.936462] pci 0000:3f:0e.0: Adding to iommu group 60
[   25.938236] pci 0000:3f:0e.1: Adding to iommu group 60
[   25.940133] pci 0000:3f:0f.0: Adding to iommu group 61
[   25.941962] pci 0000:3f:0f.1: Adding to iommu group 61
[   25.944009] pci 0000:3f:0f.2: Adding to iommu group 61
[   25.945804] pci 0000:3f:0f.3: Adding to iommu group 61
[   25.947577] pci 0000:3f:0f.4: Adding to iommu group 61
[   25.949357] pci 0000:3f:0f.5: Adding to iommu group 61
[   25.951128] pci 0000:3f:0f.6: Adding to iommu group 61
[   25.953074] pci 0000:3f:10.0: Adding to iommu group 62
[   25.954857] pci 0000:3f:10.1: Adding to iommu group 62
[   25.956616] pci 0000:3f:10.2: Adding to iommu group 62
[   25.958398] pci 0000:3f:10.3: Adding to iommu group 62
[   25.960159] pci 0000:3f:10.4: Adding to iommu group 62
[   25.962000] pci 0000:3f:10.5: Adding to[   26.414163] pci 0000:3f:10.6: =
Adding to iommu group 62
[   26.465351] pci 0000:3f:10.7: Adding to iommu group 62
[   26.467129] pci 0000:3f:11.0: Adding to iommu group 63
[   26.469007] pci 0000:3f:13.0: Adding to iommu group 64
[   26.470777] pci 0000:3f:13.1: Adding to iommu group 64
[   26.472631] pci 0000:3f:13.4: Adding to iommu group 64
[   26.474409] pci 0000:3f:13.5: Adding to iommu group 64
[   26.476155] pci 0000:3f:13.6: Adding to iommu group 64
[   26.477875] DMAR: Intel(R) Virtualization Technology for Directed I/O
[   26.506031] Initialise system trusted keyrings
[   26.507588] Key type blacklist registered
[   26.509032] workingset: timestamp_bits=3D36 max_order=3D24 bucket_order=
=3D0
[   27.272245] zbud: loaded
[   27.493313] tsc: Refined TSC clocksource calibration: 2294.470 MHz
[   27.495552] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x211=
2cd48ccb, max_idle_ns: 440795253384 ns
[   27.498868] DMAR: DRHD: handling fault status reg 2
[   27.498868] DMAR: [DMA Read] Request device [02:00.0] PASID ffffffff fau=
lt addr bdf83000 [fault reason 06] PTE Read access is not set
[   27.498868] DMAR: [DMA Read] Request device [01:00.2] PASID ffffffff fau=
lt addr f4000 [fault reason 06] PTE Read access is not set
[   27.498868] NMI: IOCK error (debug interrupt?) for reason 71 on CPU 0.
[   27.498868] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-1.elrdy.x86_=
64 #1
[   27.498868] Hardware name: HP ProLiant DL388p Gen8, BIOS P70 07/01/2015
[   27.498868] RIP: 0010:do_IRQ+0x37/0xe0
[   27.498868] Code: 65 4c 8b 25 63 36 81 77 f7 d3 65 48 89 3d 59 36 81 77 =
e8 cc c7 6d ff 89 dd 65 c6 05 64 74 82 77 01 65 48 8b 3c ed 40 53 01 00 <48=
> 85 ff 74 4e 48 81 ff 00 f0 ff ff 77 20 48 8b 47 68 e8 c2 f2 1f
[   27.498868] RSP: 0000:ffffc19240003fd8 EFLAGS: 00000086
[   27.498868] RAX: 0000000080000000 RBX: 0000000000000022 RCX: 000000062c1=
38e70
[   27.498868] RDX: 00000000000f00a5 RSI: 000000062c138e31 RDI: ffff9f10c7c=
0da00
[   27.498868] RBP: 0000000000000022 R08: fffffffffff0bdca R09: 00000000000=
29180
[   27.498868] R10: 0001009128a2c99d R11: 0000000000000000 R12: 00000000000=
00000
[   27.498868] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[   27.498868] FS:  0000000000000000(0000) GS:ffff9f109f400000(0000) knlGS:=
0000000000000000
[   27.498868] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.498868] CR2: ffff9f0fc9e01000 CR3: 000000074900a001 CR4: 00000000000=
606f0
[   27.498868] Call Trace:
[   27.498868]  <IRQ>
[   27.498868]  common_interrupt+0xf/0xf
[   27.498868]  </IRQ>
[   27.498868] RIP: 0010:mwait_idle+0x94/0x1c0
[   27.498868] Code: 00 5f 01 00 48 89 d1 0f 01 c8 48 8b 00 a8 08 0f 85 a3 =
00 00 00 e9 07 00 00 00 0f 00 2d 27 79 51 00 31 c0 48 89 c1 fb 0f 01 c9 <65=
> 8b 2d e5 49 92 77 66 66 66 66 90 e9 7c ff ff ff 65 8b 05 d4 49
[   27.498868] RSP: 0000:ffffffff89203ea8 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffffdd
[   27.498868] RAX: 0000000000000000 RBX: 0000000000000 RCX: 00000000000000=
00
[   27.498868] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000050e9=
94e82
[   27.498868] RBP: 0000000000000000 R08: fffffffffff0cdba R09: 00000000000=
29180
[   27.498868] R10: 00010091281774e6 R11: 0000000000000000 R12: 00000000000=
00000
[   27.498868] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[   27.498868]  ? tick_nohz_idle_stop_tick+0xb3/0xc0
[   27.498868]  do_idle+0x1ad/0x230
[   27.498868]  cpu_startup_entry+0x19/0x20
[   27.498868]  start_kernel+0x521/0x53f
[   27.498868]  secondary_startup_64+0xb6/0xc0
[   27.498868] NMI: IOCK error (debug interrupt?) for reason 61 on CPU 0.
[   27.498868] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-1.elrdy.x86_=
64 #1
[   27.498868] Hardware name: HP ProLiant DL388p Gen8, BIOS P70 07/01/2015
[   27.498868] RIP: 0010:do_IRQ+0x37/0xe0
[   27.498868] Code: 65 4c 8b 25 63 36 81 77 f7 d3 65 48 89 3d 59 36 81 77 =
e8 cc c7 6d ff 89 dd 65 c6 05 64 74 82 77 01 65 48 8b 3c ed 40 53 01 00 <48=
> 85 ff 74 4e 48 81 ff 00 f0 ff ff 77 20 48 8b 47 68 e8 c2 f2 1f
[   27.498868] RSP: 0000:ffffc19240003fd8 EFLAGS: 00000086
[   27.498868] RAX: 0000000080000000 RBX: 0000000000000022 RCX: 000000062c1=
38e70
[   27.498868] RDX: 00000000000f00a5 RSI: 000000062c138e30c7c0da00
[   27.498868] RBP: 0000000000000022 R08: fffffffffff0bdca R09: 00000000000=
29180
[   27.498868] R10: 0001009128a2c99d R11: 0000000000000000 R12: 00000000000=
00000
[   27.498868] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[   27.498868] FS:  0000000000000000(0000) GS:ffff9f109f400000(0000) knlGS:=
0000000000000000
[   27.498868] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.498868] CR2: ffff9f0fc9e01000 CR3: 000000074900a001 CR4: 00000000000=
606f0
[   27.498868] Call Trace:
[   27.498868]  <IRQ>
[   27.498868]  common_interrupt+0xf/0xf
[   27.498868]  </IRQ>
[   27.498868] RIP: 0010:mwait_idle+0x94/0x1c0
[   27.498868] Code: 00 5f 01 00 48 89 d1 0f 01 c8 48 8b 00 a8 08 0f 85 a3 =
00 00 00 e9 07 00 00 00 0f 00 2d 27 79 51 00 31 c0 48 89 c1 fb 0f 01 c9 <65=
> 8b 2d e5 49 92 77 66 66 66 66 90 e9 7c ff ff ff 65 8b 05 d4 49
[   27.498868] RSP: 0000:ffffffff89203ea8 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffffdd
[   27.498868] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[   27.498868] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000050e9=
94e82
[   27.498868] RBP: 0000000000000000 R08: fffffffffff0cdba R09: 00000000000=
29180
[   27.498868] R10: 00010091281774e6 R11: 0000000000000000 R12: 00000000000=
00000
[   27.498868] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[   27.498868]  ? tick_nohz_idle_stop_tick+0xb3/0xc0
[   27.498868]  do_idle+0x1ad/0x230
[   27.498868]  cpu_sta20
[   27.498868]  start_kernel+0x521/0x53f
[   27.498868]  secondary_startup_64+0xb6/0xc0
[   27.498868] NMI: IOCK error (debug interrupt?) for reason 71 on CPU 0.
[   27.498868] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-1.elrdy.x86_=
64 #1
[   27.498868] Hardware name: HP ProLiant DL388p Gen8, BIOS P70 07/01/2015
[   27.498868] RIP: 0010:do_IRQ+0x37/0xe0
[   27.498868] Code: 65 4c 8b 25 63 36 81 77 f7 d3 65 48 89 3d 59 36 81 77 =
e8 cc c7 6d ff 89 dd 65 c6 05 64 74 82 77 01 65 48 8b 3c ed 40 53 01 00 <48=
> 85 ff 74 4e 48 81 ff 00 f0 ff ff 77 20 48 8b 47 68 e8 c2 f2 1f
[   27.498868] RSP: 0000:ffffc19240003fd8 EFLAGS: 00000086
[   27.498868] RAX: 0000000080000000 RBX: 0000000000000022 RCX: 000000062c1=
38e70
[   27.498868] RDX: 00000000000f00a5 RSI: 000000062c138e31 RDI: ffff9f10c7c=
0da00
[   27.498868] RBP: 0000000000000022 R08: fffffffffff0bdca R09: 00000000000=
29180
[   27.498868] R10: 0001009128a2c99d R11: 0000000000000000 R12: 00000000000=
00000
[   27.498868] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[   27.498868] FS:  0000000000000000(0000) GS:ffff9f109f400000(0000) knlGS:=
0000000000000000
[   27.498868] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.498868] CR2: ffff9f0fc9e01000 CR3: 000000074900a001 CR4
[   27.498868] Call Trace:
[   27.498868]  <IRQ>
[   27.498868]  common_interrupt+0xf/0xf
[   27.498868]  </IRQ>
[   27.498868] RIP: 0010:mwait_idle+0x94/0x1c0
[   27.498868] Code: 00 5f 01 00 48 89 d1 0f 01 c8 48 8b 00 a8 08 0f 85 a3 =
00 00 00 e9 07 00 00 00 0f 00 2d 27 79 51 00 31 c0 48 89 c1 fb 0f 01 c9 <65=
> 8b 2d e5 49 92 77 66 66 66 66 90 e9 7c ff ff ff 65 8b 05 d4 49
[   27.498868] RSP: 0000:ffffffff89203ea8 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffffdd
[   27.498868] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[   27.498868] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000050e9=
94e82
[   27.498868] RBP: 0000000000000000 R08: fffffffffff0cdba R09: 00000000000=
29180
[   27.498868] R10: 00010091281774e6 R11: 0000000000000000 R12: 00000000000=
00000
[   27.498868] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[   27.498868]  ? tick_nohz_idle_stop_tick+0xb3/0xc0
[   27.498868]  do_idle+0x1ad/0x230
[   27.498868]  cpu_startup_entry+0x19/0x20
[   27.498868]  start_kernel+0x521/0x53f
[   27.498868]  secondary_startup_64+0xb6/0xc0
[   27.498868] NMI: IOCK error (debug interrupt?) for reason 61 on CPU 0.
[   27.498868] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-1.elr 27.498=
868] Hardware name: HP ProLiant DL388p Gen8, BIOS P70 07/01/2015
[   27.498868] RIP: 0010:do_IRQ+0x37/0xe0
[   27.498868] Code: 65 4c 8b 25 63 36 81 77 f7 d3 65 48 89 3d 59 36 81 77 =
e8 cc c7 6d ff 89 dd 65 c6 05 64 74 82 77 01 65 48 8b 3c ed 40 53 01 00 <48=
> 85 ff 74 4e 48 81 ff 00 f0 ff ff 77 20 48 8b 47 68 e8 c2 f2 1f
[   27.498868] RSP: 0000:ffffc19240003fd8 EFLAGS: 00000086
[   27.498868] RAX: 0000000080000000 RBX: 0000000000000022 RCX: 000000062c1=
38e70
[   27.498868] RDX: 00000000000f00a5 RSI: 000000062c138e31 RDI: ffff9f10c7c=
0da00
[   27.498868] RBP: 0000000000000022 R08: fffffffffff0bdca R09: 00000000000=
29180
[   27.498868] R10: 0001009128a2c99d R11: 0000000000000000 R12: 00000000000=
00000
[   27.498868] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[   27.498868] FS:  0000000000000000(0000) GS:ffff9f109f400000(0000) knlGS:=
0000000000000000
[   27.498868] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.498868] CR2: ffff9f0fc9e01000 CR3: 000000074900a001 CR4: 00000000000=
606f0
[   27.498868] Call Trace:
[   27.498868]  <IRQ>
[   27.498868]  common_interrupt+0xf/0xf
[   27.498868]  </IRQ>
[   27.498868] RIP: 0010:mwait_idle+0x94/0x1c0
[   27.498868] Code: 00 5f 01 00 48 89 d1 0f 01 c8 48 8b 00 a8 08 0f 85 a3 =
00 00 00 e9 07 00 00 00 0f 00 2d 27 79 51 00 31 c0 48 89 c1 fb 0f 01 c9 <65=
92 77 66 66 66 66 90 e9 7c ff ff ff 65 8b 05 d4 49
[   27.498868] RSP: 0000:ffffffff89203ea8 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffffdd
[   27.498868] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[   27.498868] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000050e9=
94e82
[   27.498868] RBP: 0000000000000000 R08: fffffffffff0cdba R09: 00000000000=
29180
[   27.498868] R10: 00010091281774e6 R11: 0000000000000000 R12: 00000000000=
00000
[   27.498868] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[   27.498868]  ? tick_nohz_idle_stop_tick+0xb3/0xc0
[   27.498868]  do_idle+0x1ad/0x230
[   27.498868]  cpu_startup_entry+0x19/0x20
[   27.498868]  start_kernel+0x521/0x53f
[   27.498868]  secondary_startup_64+0xb6/0xc0
[   37.963387] DMAR: DRHD: handling fault status reg 202
[   37.964382] DMAR: [DMA Read] Request device [01:00.2] PASID ffffffff fau=
lt addr bdf6f000 [fault reason 06] PTE Read access is not set
[   37.969040] clocksource: Switched to clocksource tsc
[   37.976281] NET: Registered protocol family 38
[   37.977803] Key type asymmetric registered
[   37.979205] Asymmetric key parser 'x509'38.326117] Block layer SCSI gene=
ric (bsg) driver version 0.4 loaded (major 247)
[   38.354549] DMAR: DRHD: handling fault status reg 302
[   38.483363] io scheduler mq-deadline registered
[   38.483229] DMAR: [DMA Read] Request device [01:00.2] PASID ffffffff fau=
lt addr bdf6f000 [fault reason 06] PTE Read access is not set
[   38.490536] io scheduler kyber registered
[   38.492001] io scheduler bfq registered
[   38.493709] atomic64_test: passed for x86-64 platform with CX8 and with =
SSE
[   38.506366] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   38.511473] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input0
[   38.514125] ACPI: Power Button [PWRF]
[   38.517747] thermal LNXTHERM:00: registered as thermal_zone0
[   38.519998] ACPI: Thermal Zone [THM0] (8 C)
[   38.521534] ERST: Error Record Serialization Table (ERST) support is ini=
tialized.
[   38.524098] pstore: Registered erst as persistent store backend
[   38.526185] GHES: APEI firmware first mode is enabled by APEI bit and WH=
EA _OSC.
[   38.528992] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   38.551775] 00:02: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[   38.575137] serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 115=
200) is a 16550A
[   38.579209] Non-volatile m1.3
[   38.980704] Linux agpgart interface v0.103
[   38.986794] rdac: device handler registered
[   38.988402] hp_sw: device handler registered
[   38.989860] emc: device handler registered
[   38.991391] alua: device handler registered
[   38.992918] libphy: Fixed MDIO Bus: probed
[   38.994458] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   38.996624] ehci-pci: EHCI PCI platform driver
[   38.998539] ehci-pci 0000:00:1a.0: EHCI Host Controller
[   39.000492] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus =
number 1
[   39.003028] ehci-pci 0000:00:1a.0: debug port 2
[   39.005587] ehci-pci 0000:00:1a.0: Using iommu dma mapping
[   39.007421] ehci-pci 0000:00:1a.0: DMAR: 32bit DMA uses non-identity map=
ping
[   39.013689] ehci-pci 0000:00:1a.0: cache line size of 64 is not supporte=
d
[   39.015990] ehci-pci 0000:00:1a.0: irq 21, io mem 0xf6c60000
[   39.024342] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[   39.026374] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.04
[   39.029128] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   39.031521] usb usb1: Product: EHCI Host Controller
[   39.033235] usb usb1: Manufacturer: Linux 5.4.0-1.elrdy.x86_64 ehci_hcd
[   39.035433] usb usb1: SerialNumber: 0000:00:1a.0
[   39.037312] hub 1-0:1.0: USB hub found
[   39.038602] hub 1-0:1.0: 2 ports detected
[   39.040601] ehcid.0: EHCI Host Controller
[   39.442585] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus =
number 2
[   39.445220] ehci-pci 0000:00:1d.0: debug port 2
[   39.447471] ehci-pci 0000:00:1d.0: Using iommu dma mapping
[   39.449784] ehci-pci 0000:00:1d.0: DMAR: 32bit DMA uses non-identity map=
ping
[   39.456174] ehci-pci 0000:00:1d.0: cache line size of 64 is not supporte=
d
[   39.458515] ehci-pci 0000:00:1d.0: irq 20, io mem 0xf6c50000
[   39.467348] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[   39.469368] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.04
[   39.472545] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   39.474963] usb usb2: Product: EHCI Host Controller
[   39.476605] usb usb2: Manufacturer: Linux 5.4.0-1.elrdy.x86_64 ehci_hcd
[   39.478797] usb usb2: SerialNumber: 0000:00:1d.0
[   39.480599] hub 2-0:1.0: USB hub found
[   39.481906] hub 2-0:1.0: 2 ports detected
[   39.483594] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   39.485754] ohci-pci: OHCI PCI platform driver
[   39.487402] uhci_hcd: USB Universal Host Controller Interface driver
[   3 0000:01:00.4: UHCI Host Controller
[   39.991418] uhci_hcd 0000:01:00.4: new USB bus registered, assigned bus =
number 3
[   39.993992] uhci_hcd 0000:01:00.4: detected 8 ports
[   39.995643] uhci_hcd 0000:01:00.4: port count misdetected? forcing to 2 =
ports
[   39.998040] uhci_hcd 0000:01:00.4: irq 16, io base 0x00003c00
[   40.000159] uhci_hcd 0000:01:00.4: DMAR: 32bit DMA uses non-identity map=
ping
[   40.002591] uhci_hcd 0000:01:00.4: unable to allocate consistent memory =
for frame list
[   40.005225] uhci_hcd 0000:01:00.4: startup error -16
[   40.006881] uhci_hcd 0000:01:00.4: USB bus 3 deregistered
[   40.008891] uhci_hcd 0000:01:00.4: init 0000:01:00.4 fail, -16
[   40.010882] uhci_hcd: probe of 0000:01:00.4 failed with error -16
[   40.013260] usbcore: registered new interface driver usbserial_generic
[   40.015554] usbserial: USB Serial support registered for generic
[   40.017670] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at 0x=
60,0x64 irq 1,12
[   40.023064] serio: i8042 KBD port at 0x60,0x64 irq 1
[   40.024809] serio: i8042 AUX port at 0x60,0x64 irq 12
[   40.026831] mousedev: PS/2 mouse device common for all mice
[   40.029084] rtc_cmos 00:0om S4
[   40.122366] usb 1-1: new high-speed USB device number 2 using ehci-pci
[   40.530546] dmar_fault: 3 callbacks suppressed
[   40.530547] DMAR: DRHD: handling fault status reg 502
[   40.530550] DMAR: [DMA Read] Request device [01:00.2] PASID ffffffff fau=
lt addr bdf6f000 [fault reason 06] PTE Read access is not set
[   40.530862] rtc_cmos 00:03: registered as rtc0
[   40.541475] rtc_cmos 00:03: alarms up to one day, 114 bytes nvram, hpet =
irqs
[   40.543929] intel_pstate: Intel P-state driver initializing
[   40.548702] hidraw: raw HID events driver (C) Jiri Kosina
[   40.550559] usbcore: registered new interface driver usbhid
[   40.552493] usbhid: USB HID core driver
[   40.553883] drop_monitor: Initializing network drop monitor service
[   40.556064] Initializing XFRM netlink socket
[   40.557787] NET: Registered protocol family 10
[   40.559874] Segment Routing with IPv6
[   40.561167] NET: Registered protocol family 17
[   40.562922] mpls_gso: MPLS GSO support
[   40.567394] microcode: sig=3D0x206d7, pf=3D0x1, revision=3D0x710
[   40.569957] microcode: Microcode Update Driver: v2.2.
[   40.569960] IPI shorthand broadcast: enabl4325] usb 2-1: new high-speed =
USB device number 2 using ehci-pci
[   40.680863] AVX version of gcm_enc/dec engaged.
[   40.976911] AES CTR mode by8 optimization enabled
[   41.041865] usb 1-1: New USB device found, idVendor=3D8087, idProduct=3D=
0024, bcdDevice=3D 0.00
[   41.044686] usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[   41.047567] hub 1-1:1.0: USB hub found
[   41.049124] hub 1-1:1.0: 6 ports detected
[   41.069397] sched_clock: Marking stable (36280828753, 4788532579)->(4211=
7913144, -1048551812)
[   41.072745] registered taskstats version 1
[   41.074169] Loading compiled-in X.509 certificates
[   41.104029] usb 2-1: New USB device found, idVendor=3D8087, idProduct=3D=
0024, bcdDevice=3D 0.00
[   41.106779] usb 2-1: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[   41.109691] hub 2-1:1.0: USB hub found
[   41.111144] hub 2-1:1.0: 8 ports detected
[   41.169154] Loaded X.509 cert 'Red Hat Enterprise Linux kernel signing k=
ey: 8c404550f293ed26629b825d4c1d0241b9c443b3'
[   41.173102] zswap: loaded using pool lzo/zbud
[   41.174917] pstore: Using crash dump compression: deflate
[   41.195587] Key type big_key registered
[   41.205950] Key type encrypted registered
[   41.207384] ima: No Tund, activating TPM-bypass!
[   41.357073] DMAR: DRHD: handling fault status reg 602
[   41.509136] ima: Allocated hash algorithm: sha1
[   41.510828] DMAR: [DMA Read] Request device [01:00.2] PASID ffffffff fau=
lt addr bdf6f000 [fault reason 06] PTE Read access is not set
[   41.510865] usb 2-1.3: new high-speed USB device number 3 using ehci-pci
[   41.512456] ima: No architecture policies found
[   41.520557] evm: Initialising EVM extended attributes:
[   41.522358] evm: security.selinux
[   41.523487] evm: security.ima
[   41.524503] evm: security.capability
[   41.525743] evm: HMAC attrs: 0x1
[   41.527889] rtc_cmos 00:03: setting system clock to 2019-12-04T15:41:17 =
UTC (1575474077)
[   41.533022] Freeing unused decrypted memory: 2040K
[   41.555630] Freeing unused kernel image memory: 2388K
[   41.583373] Write protecting the kernel read-only data: 20480k
[   41.594712] usb 2-1.3: New USB device found, idVendor=3D0424, idProduct=
=3D2660, bcdDevice=3D 8.01
[   41.647397] usb 2-1.3: New USB device strings: Mfr=3D0, Product=3D0, Ser=
ialNumber=3D0
[   41.681369] hub 2-1.3:1.0: USB hub found
[   41.699207] hub 2-1.3:1.0: 2 ports detected
[   41.699596] Freeing unused kernel image memory: 2008K
[   41.741511] Freeing unused kernel image memory: 1952K
[   41.779962] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   41.809315] x86/mm: Checking user space page tables
[   41.845804] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   41.874970] Run /init as init process
[   42.007276] DMAR: DRHD: handling fault status reg 702
[   42.009687] ERST: [Firmware Warn]: Firmware does not respond in time.
[   42.030277] DMAR: [DMA Read] Request device [01:00.2] PASID ffffffff fau=
lt addr e8000 [fault reason 06] PTE Read access is not set
[   42.115384] systemd[1]: systemd 239 running in system mode. (+PAM +AUDIT=
 +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNU=
TLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default=
-hierarchy=3Dlegacy)
[   42.229446] systemd[1]: Detected architecture x86-64.
[   42.252166] systemd[1]: Running in initial RAM disk.

Welcome to Red Hat Enterprise Linux 8.2 Beta (Ootpa) dracut-049-57.git20191=
031.el8 (Initramfs)!

[   42.284606] systemd[1]: Set hostname to <hp-dl388g8-07.rhts.eng.pek2.red=
hat.com>.
[   42.359206] DMAR: DRHD: handling fault status reg 2
[   42.432835] random: systemd: uninitialized urandom read (16 bytes read)
[   42.462642] systemd[1]: Reached target Swap.
[  OK  ] Reached target Swap.
[   42.483710] random: systemd: uninitialized urandom read (16 bytes read)
[   42.516832] systemd[1]: Reached target Timers.
[  OK  ] Reached target Timers.
[   42.540427] random: systemd: uninitialized urandom read (16 bytes read)
[   42.570677] systemd[1]: Reached target Slices.
[  OK  ] Reached target Slices.
[   42.593644] systemd[1]: Listening on Journal Socket (/dev/log).
[  OK  ] Listening on Journal Socket (/dev/log).
[   42.623651] systemd[1]: Listening on Journal Socket.
[  OK  ] Listening on Journal Socket.
[   42.652589] systemd[1]: Starting Setup Virtual Console...
         Starting Setup Virtual Console...
         Starting Journal Service...
         Starting Apply Kernel Variables...
         Starting Create list of required st=E2=80=A6ce nodes for the curre=
nt kernel...
[  OK  ] Created slice system-systemd\x2dhibernate\x2dresume.slice.
[  OK  ] Listening on udev Control Socket.
[  OK  ] Listening on udev Kernel Socket.
[  OK  ] Reached target Sockets.
[  OK  ] Started Hardware RNG Entropy Gatherer Daemon.
[  OK  ] Started Apply Kernel Variables.
[  OK  ] Started Create list of required sta=E2=80=A6vice nodes for the cur=
rent kernel.
         Starting Create Static Device Nodes in /dev...
[  OK  ] Started Create Static Device Nodes in /dev.
[  OK  ] Started Setup Virtual Console.
         Starting dracut cmdline hook...
[  OK  ] Started dracut cmdline hook.
         Starting dracut pre-udev hook...
[   43.328740] device-mapper: uevent: version 1.0.3
[  OK  ] Started Journal Service.
[   43.349726] device-mapper: ioctl: 4.41.0-ioctl (2019-09-16) initialised:=
 dm-devel@redhat.com
[  OK  ] Started dracut pre-udev hook.
         Starting udev Kernel Device Manager...
[  OK  ] Started udev Kernel Device Manager.
         Starting udev Coldplug all Devices...
         Mounting Kernel Configuration File System...
[  OK  ] Mounted Kernel Configuration File System.
[  OK  ] Started udev Coldplug all Devices.
         Starting dracut initqueue hook...
         Starting Show Plymouth Boot Screen...
[  OK  ] Started Show Plymouth Boot Screen.
[  OK  ] Reached target Paths.
[  OK  ] Started Forward Password Requests to Plymouth Directory Watch.
[   44.029570] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[   44.059889] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   44.096144] dca service started, version 1.12.1
[   44.137216] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.6.=
0-k
[   44.168566] igb: Copyright (c) 2007-2014 Intel Corporation.
[   44.239195] igb 0000:24:00.0: added PHC on eth0
[   44.259216] igb 0000:24:00.0: Intel(R) Gigabit Ethernet Network Connecti=
on
[   44.289707] igb 0000:24:00.0: eth0: (PCIe:5.0Gb/s:Width x4) 00:1b:21:85:=
84:00
[   44.289709] igb 0000:24:00.0: eth0: PBA No: Unknown
[   44.289714] igb 0000:24:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 t=
x queue(s)
[   44.425389] igb 0000:24:00.1: added PHC on eth1
[   44.446311] igb 0000:24:00.1: Intel(R) Gigabit Ethernet Network Connecti=
on
[   44.477181] igb 0000:24:00.1: eth1: (PCIe:5.0Gb/s:Width x4) 00:1b:21:85:=
84:01
[   44.509245] igb 0000:24:00.1: eth1: PBA No: Unknown
[   44.530754] igb 0000:24:00.1: Using MSI-X interrupts. 8 rx queue(s), 8 t=
x queue(s)
[   44.611561] igb 0000:24:00.2: added PHC on eth2
[   44.631998] igb 0000:24:00.2: Intel(R) Gigabit Ethernet Network Connecti=
on
[   44.649576] random: crng init done
[   44.663205] igb 0000:24:00.2: eth2: (PCIe:5.0Gb/s:Width x4) 00:1b:21:85:=
84:02
[   44.679332] random: 7 urandom warning(s) missed due to ratelimiting
[   44.743690] igb 0000:24:00.2: eth2: PBA No: Unknown
[   44.767746] igb 0000:24:00.2: Using MSI-X interrupts. 8 rx queue(s), 8 t=
x queue(s)
[   44.847056] igb 0000:24:00.3: added PHC on eth3
[   44.868536] igb 0000:24:00.3: Intel(R) Gigabit Ethernet Network Connecti=
on
[   44.900979] igb 0000:24:00.3: eth3: (PCIe:5.0Gb/s:Width x4) 00:1b:21:85:=
84:03
[   44.934190] igb 0000:24:00.3: eth3: PBA No: Unknown
[   44.957079] igb 0000:24:00.3: Using MSI-X interrupts. 8 rx queue(s), 8 t=
x queue(s)
[   44.994901] igb 0000:24:00.3 ens5f3: renamed from eth3
[   45.026876] igb 0000:24:00.1 ens5f1: renamed from eth1
[   45.059597] igb 0000:24:00.2 ens5f2: renamed from eth2
[   45.094957] igb 0000:24:00.0 ens5f0: renamed from eth0
[   46.364986] dmar_fault: 17 callbacks suppressed
[   46.364987] DMAR: DRHD: handling fault status reg 602
[   46.414596] DMAR: [DMA Read] Request device [01:00.2] PASID ffffffff fau=
lt addr bdf6f000 [fault reason 06] PTE Read access is not set
[   47.367057] DMAR: DRHD: handling fault status reg 702
[   47.391713] DMAR: [DMA Read] Request device [01:00.2] PASID ffffffff fau=
lt addr bdf6f000 [fault reason 06] PTE Read access is not set
[   48.172274] e1000e 0000:06:00.0: Interrupt Throttling Rate (ints/sec) se=
t to dynamic conservative mode
[   48.218724] tg3.c:v3.137 (May 11, 2014)
[   48.239682] HP HPSA Driver (v 3.4.20-170-RH1)
[   48.260674] hpsa 0000:02:00.0: can't disable ASPM; OS doesn't have ASPM =
control
[   48.296188] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
[   48.320188] mgag200 0000:01:00.1: remove_conflicting_pci_framebuffers: b=
ar 0: 0xf5000000 -> 0xf5ffffff
[   48.364098] mgag200 0000:01:00.1: remove_conflicting_pci_framebuffers: b=
ar 1: 0xf7be0000 -> 0xf7be3fff
[   48.408123] DMAR: DRHD: handling fault status reg 2
[   48.408126] DMAR: [DMA Read] Request device [01:00.2] PASID ffffffff fau=
lt addr bdf6f000 [fault reason 06] PTE Read access is not set
[   48.487590] mgag200 0000:01:00.1: remove_conflicting_pci_framebuffers: b=
ar 2: 0xf7000000 -> 0xf77fffff
[   48.531446] mgag200 0000:01:00.1: vgaarb: deactivate vga console
[   48.560814] Console: switching to colour dummy device 80x25
[   48.595089] scsi host0: ata_piix
[   48.610235] [TTM] Zone  kernel: Available graphics memory: 24652642 KiB
[   48.641241] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
[   48.672252] [TTM] Initializing pool allocator
[   48.692793] [TTM] Initializing DMA pool allocator
[   48.723457] scsi host1: ata_piix
[   48.738972] ata1: SATA max UDMA/133 cmd 0x4000 ctl 0x4008 bmdma 0x4020 i=
rq 17
[   48.774438] ata2: SATA max UDMA/133 cmd 0x4010 ctl 0x4018 bmdma 0x4028 i=
rq 17
[   48.813583] fbcon: mgag200drmfb (fb0) is primary device
[   48.908103] tg3 0000:03:00.0 eth0: Tigon3 [partno(629133-002) rev 571900=
1] (PCI Express) MAC address ac:16:2d:84:39:74
[   48.908108] tg3 0000:03:00.0 eth0: attached PHY is 5719C (10/100/1000Bas=
e-T Ethernet) (WireSpeed[1], EEE[1])
[   48.908111] tg3 0000:03:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF=
[1] TSOcap[1]
[   48.908113] tg3 0000:03:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[   48.921080] tg3 0000:03:00.1 eth1: Tigon3 [partno(629133-002) rev 571900=
1] (PCI Express) MAC address ac:16:2d:84:39:75
[   48.921084] tg3 0000:03:00.1 eth1: attached PHY is 5719C (10/100/1000Bas=
e-T Ethernet) (WireSpeed[1], EEE[1])
[   48.921087] tg3 0000:03:00.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF=
[1] TSOcap[1]
[   48.921090] tg3 0000:03:00.1 eth1: dma_rwctrl[00000001] dma_mask[64-bit]
[   48.922327] Console: switching to colour frame buffer device 128x48
[   49.111114] DMAR: DRHD: handling fault status reg 102
[   49.332521] mgag200 0000:01:00.1: fb0: mgag200drmfb frame buffer device
[   49.368331] [drm] Initialized mgag200 1.0.0 20110418 for 0000:01:00.1 on=
 minor 0
[   49.409455] tg3 0000:03:00.2 eth2: Tigon3 [partno(629133-002) rev 571900=
1] (PCI Express) MAC address ac:16:2d:84:39:76
[   49.461848] tg3 0000:03:00.2 eth2: attached PHY is 5719C (10/100/1000Bas=
e-T Ethernet) (WireSpeed[1], EEE[1])
[   49.508392] tg3 0000:03:00.2 eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF=
[1] TSOcap[1]
[   49.545246] tg3 0000:03:00.2 eth2: dma_rwctrl[00000001] dma_mask[64-bit]
[   49.549783] e1000e 0000:06:00.0 eth3: (PCI Express:2.5GT/s:Width x4) 00:=
15:17:dc:98:dd
[   49.613128] e1000e 0000:06:00.0 eth3: Intel(R) PRO/1000 Network Connecti=
on
[   49.613209] e1000e 0000:06:00.0 eth3: MAC: 0, PHY: 4, PBA No: D64202-005
[   49.676115] e1000e 0000:06:00.1: Interrupt Throttling Rate (ints/sec) se=
t to dynamic conservative mode
[   49.728846] tg3 0000:03:00.3 eth4: Tigon3 [partno(629133-002) rev 571900=
1] (PCI Express) MAC address ac:16:2d:84:39:77
[   49.781375] tg3 0000:03:00.3 eth4: attached PHY is 5719C (10/100/1000Bas=
e-T Ethernet) (WireSpeed[1], EEE[1])
[   49.829247] tg3 0000:03:00.3 eth4: RXcsums[1] LinkChgREG[0] MIirq[0] ASF=
[1] TSOcap[1]
[   49.865681] tg3 0000:03:00.3 eth4: dma_rwctrl[00000001] dma_mask[64-bit]
[   49.900835] tg3 0000:03:00.1 eno2: renamed from eth1
[   49.930935] tg3 0000:03:00.0 eno1: renamed from eth0
[   49.971618] tg3 0000:03:00.2 eno3: renamed from eth2
[   50.009587] tg3 0000:03:00.3 eno4: renamed from eth4
[   50.043917] e1000e 0000:06:00.1 eth0: (PCI Express:2.5GT/s:Width x4) 00:=
15:17:dc:98:dc
[   50.081045] e1000e 0000:06:00.1 eth0: Intel(R) PRO/1000 Network Connecti=
on
[   50.113434] e1000e 0000:06:00.1 eth0: MAC: 0, PHY: 4, PBA No: D64202-005
[   50.145176] e1000e 0000:07:00.0: Interrupt Throttling Rate (ints/sec) se=
t to dynamic conservative mode
[   50.149349] ata2.01: failed to resume link (SControl 0)
[   50.224420] ata2.00: SATA link down (SStatus 0 SControl 300)
[   50.250822] ata2.01: SATA link down (SStatus 4 SControl 0)
[   50.279009] ata1.01: failed to resume link (SControl 0)
[   50.315900] ata1.00: SATA link down (SStatus 0 SControl 300)
[   50.342439] ata1.01: SATA link down (SStatus 4 SControl 0)
[   50.346316] e1000e 0000:07:00.0 eth1: (PCI Express:2.5GT/s:Width x4) 00:=
15:17:dc:98:df
[   50.405652] e1000e 0000:07:00.0 eth1: Intel(R) PRO/1000 Network Connecti=
on
[   50.438096] e1000e 0000:07:00.0 eth1: MAC: 0, PHY: 4, PBA No: D64202-005
[   50.470082] e1000e 0000:07:00.1: Interrupt Throttling Rate (ints/sec) se=
t to dynamic conservative mode
[   50.674293] e1000e 0000:07:00.1 eth2: (PCI Express:2.5GT/s:Width x4) 00:=
15:17:dc:98:de
[   50.709841] e1000e 0000:07:00.1 eth2: Intel(R) PRO/1000 Network Connecti=
on
[   50.740890] e1000e 0000:07:00.1 eth2: MAC: 0, PHY: 4, PBA No: D64202-005
[   50.775942] e1000e 0000:07:00.0 ens1f0: renamed from eth1
[   50.813818] e1000e 0000:07:00.1 ens1f1: renamed from eth2
[   51.375720] dmar_fault: 8 callbacks suppressed
[   51.375723] DMAR: DRHD: handling fault status reg 402
[   51.425802] DMAR: [DMA Read] Request device [01:00.2] PASID ffffffff fau=
lt addr bdf6f000 [fault reason 06] PTE Read access is not set
[   52.376646] DMAR: DRHD: handling fault status reg 502
[   52.402441] DMAR: [DMA Read] Request device [01:00.2] PASID ffffffff fau=
lt addr bdf6f000 [fault reason 06] PTE Read access is not set
[   53.377497] DMAR: DRHD: handling fault status reg 602
[   53.403884] DMAR: [DMA Read] Request device [01:00.2] PASID ffffffff fau=
lt addr bdf6f000 [fault reason 06] PTE Read access is not set
[   54.094325] DMAR: DRHD: handling fault status reg 702
[   56.381429] dmar_fault: 14 callbacks suppressed
[   56.381432] DMAR: DRHD: handling fault status reg 402
[   56.431218] DMAR: [DMA Read] Request device [01:00.2] PASID ffffffff fau=
lt addr bdf6f000 [fault reason 06] PTE Read access is not set
[   56.561356] DMAR: DRHD: handling fault status reg 502
[   56.584460] DMAR: [DMA Read] Request device [01:00.2] PASID ffffffff fau=
lt addr bdf83000 [fault reason 06] PTE Read access is not set
[   57.382311] DMAR: DRHD: handling fault status reg 602
[   57.409148] DMAR: [DMA Read] Request device [01:00.2] PASID ffffffff fau=
lt addr bdf6f000 [fault reason 06] PTE Read access is not set
[   57.569711] DMAR: DRHD: handling fault status reg 702
[   61.385588] dmar_fault: 26 callbacks suppressed
[   61.385591] DMAR: DRHD: handling fault status reg 2
[   61.434765] DMAR: [DMA Read] Request device [01:00.2] PASID ffffffff fau=
lt addr bdf6f000 [fault reason 06] PTE Read access is not set
[   61.597887] DMAR: DRHD: handling fault status reg 102
[   61.621337] DMAR: [DMA Read] Request device [01:00.2] PASID ffffffff fau=
lt addr bdf83000 [fault reason 06] PTE Read access is not set
[   62.386532] DMAR: DRHD: handling fault status reg 202
[   62.413871] DMAR: [DMA Read] Request device [01:00.2] PASID ffffffff fau=
lt addr bdf6f000 [fault reason 06] PTE Read access is not set
[   62.606154] DMAR: DRHD: handling fault status reg 302
[   66.392231] dmar_fault: 26 callbacks suppressed
[   66.392233] DMAR: DRHD: handling fault status reg 402
[   66.441876] DMAR: [DMA Read] Request device [01:00.2] PASID ffffffff fau=
lt addr bdf6f000 [fault reason 06] PTE Read access is not set
[   66.631917] DMAR: DRHD: handling fault status reg 502
[   66.655106] DMAR: [DMA Read] Request device [01:00.2] PASID ffffffff fau=
lt addr bdf83000 [fault reason 06] PTE Read access is not set
[   67.392987] DMAR: DRHD: handling fault s[tatus reg 602
[   67.419734] DMAR: [DMA Read] Request device [01:00.2] PASID ffffffff fau=
lt addr bdf6f000 [fault reason 06] PTE Read access is not set
[   67.640410] DMAR: DRHD: handling fault status reg 702

--omz5tebd6o7fekfs
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="config-5.4.0-1.elrdy.x86_64"
Content-Transfer-Encoding: quoted-printable

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.4.0-1.elrdy.x86_64 Kernel Configuration
#

#
# Compiler: gcc (GCC) 8.2.1 20180905 (Red Hat 8.2.1-3)
#
CONFIG_CC_IS_GCC=3Dy
CONFIG_GCC_VERSION=3D80201
CONFIG_CLANG_VERSION=3D0
CONFIG_CC_CAN_LINK=3Dy
CONFIG_CC_HAS_ASM_GOTO=3Dy
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=3Dy
CONFIG_IRQ_WORK=3Dy
CONFIG_BUILDTIME_EXTABLE_SORT=3Dy
CONFIG_THREAD_INFO_IN_TASK=3Dy

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=3D32
# CONFIG_COMPILE_TEST is not set
CONFIG_HEADER_TEST=3Dy
CONFIG_KERNEL_HEADER_TEST=3Dy
CONFIG_UAPI_HEADER_TEST=3Dy
CONFIG_LOCALVERSION=3D""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_BUILD_SALT=3D""
CONFIG_HAVE_KERNEL_GZIP=3Dy
CONFIG_HAVE_KERNEL_BZIP2=3Dy
CONFIG_HAVE_KERNEL_LZMA=3Dy
CONFIG_HAVE_KERNEL_XZ=3Dy
CONFIG_HAVE_KERNEL_LZO=3Dy
CONFIG_HAVE_KERNEL_LZ4=3Dy
CONFIG_KERNEL_GZIP=3Dy
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME=3D"(none)"
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_SYSVIPC_SYSCTL=3Dy
CONFIG_POSIX_MQUEUE=3Dy
CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
CONFIG_CROSS_MEMORY_ATTACH=3Dy
# CONFIG_USELIB is not set
CONFIG_AUDIT=3Dy
CONFIG_HAVE_ARCH_AUDITSYSCALL=3Dy
CONFIG_AUDITSYSCALL=3Dy

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=3Dy
CONFIG_GENERIC_IRQ_SHOW=3Dy
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=3Dy
CONFIG_GENERIC_PENDING_IRQ=3Dy
CONFIG_GENERIC_IRQ_MIGRATION=3Dy
CONFIG_IRQ_DOMAIN=3Dy
CONFIG_IRQ_DOMAIN_HIERARCHY=3Dy
CONFIG_GENERIC_MSI_IRQ=3Dy
CONFIG_GENERIC_MSI_IRQ_DOMAIN=3Dy
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=3Dy
CONFIG_GENERIC_IRQ_RESERVATION_MODE=3Dy
CONFIG_IRQ_FORCED_THREADING=3Dy
CONFIG_SPARSE_IRQ=3Dy
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=3Dy
CONFIG_ARCH_CLOCKSOURCE_DATA=3Dy
CONFIG_ARCH_CLOCKSOURCE_INIT=3Dy
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=3Dy
CONFIG_GENERIC_TIME_VSYSCALL=3Dy
CONFIG_GENERIC_CLOCKEVENTS=3Dy
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=3Dy
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=3Dy
CONFIG_GENERIC_CMOS_UPDATE=3Dy

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=3Dy
CONFIG_NO_HZ_COMMON=3Dy
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=3Dy
CONFIG_CONTEXT_TRACKING=3Dy
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=3Dy
CONFIG_HIGH_RES_TIMERS=3Dy
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=3Dy
# CONFIG_PREEMPT is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=3Dy
CONFIG_VIRT_CPU_ACCOUNTING_GEN=3Dy
CONFIG_IRQ_TIME_ACCOUNTING=3Dy
CONFIG_HAVE_SCHED_AVG_IRQ=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_BSD_PROCESS_ACCT_V3=3Dy
CONFIG_TASKSTATS=3Dy
CONFIG_TASK_DELAY_ACCT=3Dy
CONFIG_TASK_XACCT=3Dy
CONFIG_TASK_IO_ACCOUNTING=3Dy
CONFIG_PSI=3Dy
# CONFIG_PSI_DEFAULT_DISABLED is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=3Dy

#
# RCU Subsystem
#
CONFIG_TREE_RCU=3Dy
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=3Dy
CONFIG_TREE_SRCU=3Dy
CONFIG_RCU_STALL_COMMON=3Dy
CONFIG_RCU_NEED_SEGCBLIST=3Dy
CONFIG_RCU_NOCB_CPU=3Dy
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=3Dy
# CONFIG_IKCONFIG is not set
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=3D20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=3D13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=3Dy
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=3Dy
CONFIG_ARCH_SUPPORTS_INT128=3Dy
CONFIG_NUMA_BALANCING=3Dy
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=3Dy
CONFIG_CGROUPS=3Dy
CONFIG_PAGE_COUNTER=3Dy
CONFIG_MEMCG=3Dy
CONFIG_MEMCG_SWAP=3Dy
CONFIG_MEMCG_SWAP_ENABLED=3Dy
CONFIG_MEMCG_KMEM=3Dy
CONFIG_BLK_CGROUP=3Dy
CONFIG_CGROUP_WRITEBACK=3Dy
CONFIG_CGROUP_SCHED=3Dy
CONFIG_FAIR_GROUP_SCHED=3Dy
CONFIG_CFS_BANDWIDTH=3Dy
CONFIG_RT_GROUP_SCHED=3Dy
CONFIG_CGROUP_PIDS=3Dy
CONFIG_CGROUP_RDMA=3Dy
CONFIG_CGROUP_FREEZER=3Dy
CONFIG_CGROUP_HUGETLB=3Dy
CONFIG_CPUSETS=3Dy
CONFIG_PROC_PID_CPUSET=3Dy
CONFIG_CGROUP_DEVICE=3Dy
CONFIG_CGROUP_CPUACCT=3Dy
CONFIG_CGROUP_PERF=3Dy
CONFIG_CGROUP_BPF=3Dy
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=3Dy
CONFIG_NAMESPACES=3Dy
CONFIG_UTS_NS=3Dy
CONFIG_IPC_NS=3Dy
CONFIG_USER_NS=3Dy
CONFIG_PID_NS=3Dy
CONFIG_NET_NS=3Dy
CONFIG_CHECKPOINT_RESTORE=3Dy
CONFIG_SCHED_AUTOGROUP=3Dy
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=3Dy
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_RD_GZIP=3Dy
CONFIG_RD_BZIP2=3Dy
CONFIG_RD_LZMA=3Dy
CONFIG_RD_XZ=3Dy
CONFIG_RD_LZO=3Dy
CONFIG_RD_LZ4=3Dy
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=3Dy
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=3Dy
CONFIG_HAVE_UID16=3Dy
CONFIG_SYSCTL_EXCEPTION_TRACE=3Dy
CONFIG_HAVE_PCSPKR_PLATFORM=3Dy
CONFIG_BPF=3Dy
# CONFIG_EXPERT is not set
CONFIG_UID16=3Dy
CONFIG_MULTIUSER=3Dy
CONFIG_SGETMASK_SYSCALL=3Dy
CONFIG_SYSFS_SYSCALL=3Dy
CONFIG_FHANDLE=3Dy
CONFIG_POSIX_TIMERS=3Dy
CONFIG_PRINTK=3Dy
CONFIG_PRINTK_NMI=3Dy
CONFIG_BUG=3Dy
CONFIG_ELF_CORE=3Dy
CONFIG_PCSPKR_PLATFORM=3Dy
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
CONFIG_FUTEX_PI=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SIGNALFD=3Dy
CONFIG_TIMERFD=3Dy
CONFIG_EVENTFD=3Dy
CONFIG_SHMEM=3Dy
CONFIG_AIO=3Dy
CONFIG_IO_URING=3Dy
CONFIG_ADVISE_SYSCALLS=3Dy
CONFIG_MEMBARRIER=3Dy
CONFIG_KALLSYMS=3Dy
CONFIG_KALLSYMS_ALL=3Dy
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=3Dy
CONFIG_KALLSYMS_BASE_RELATIVE=3Dy
CONFIG_BPF_SYSCALL=3Dy
CONFIG_BPF_JIT_ALWAYS_ON=3Dy
CONFIG_USERFAULTFD=3Dy
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=3Dy
CONFIG_RSEQ=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=3Dy

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=3Dy
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=3Dy
CONFIG_SLUB_DEBUG=3Dy
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=3Dy
CONFIG_SLAB_MERGE_DEFAULT=3Dy
CONFIG_SLAB_FREELIST_RANDOM=3Dy
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=3Dy
CONFIG_SLUB_CPU_PARTIAL=3Dy
CONFIG_SYSTEM_DATA_VERIFICATION=3Dy
CONFIG_PROFILING=3Dy
CONFIG_TRACEPOINTS=3Dy
# end of General setup

CONFIG_64BIT=3Dy
CONFIG_X86_64=3Dy
CONFIG_X86=3Dy
CONFIG_INSTRUCTION_DECODER=3Dy
CONFIG_OUTPUT_FORMAT=3D"elf64-x86-64"
CONFIG_ARCH_DEFCONFIG=3D"arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=3Dy
CONFIG_STACKTRACE_SUPPORT=3Dy
CONFIG_MMU=3Dy
CONFIG_ARCH_MMAP_RND_BITS_MIN=3D28
CONFIG_ARCH_MMAP_RND_BITS_MAX=3D32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=3D8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=3D16
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_GENERIC_BUG=3Dy
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=3Dy
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_ARCH_HAS_CPU_RELAX=3Dy
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=3Dy
CONFIG_ARCH_HAS_FILTER_PGPROT=3Dy
CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=3Dy
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy
CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
CONFIG_ARCH_WANT_GENERAL_HUGETLB=3Dy
CONFIG_ZONE_DMA32=3Dy
CONFIG_AUDIT_ARCH=3Dy
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
CONFIG_HAVE_INTEL_TXT=3Dy
CONFIG_X86_64_SMP=3Dy
CONFIG_ARCH_SUPPORTS_UPROBES=3Dy
CONFIG_FIX_EARLYCON_MEM=3Dy
CONFIG_DYNAMIC_PHYSICAL_MASK=3Dy
CONFIG_PGTABLE_LEVELS=3D5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=3Dy

#
# Processor type and features
#
CONFIG_ZONE_DMA=3Dy
CONFIG_SMP=3Dy
CONFIG_X86_FEATURE_NAMES=3Dy
CONFIG_X86_X2APIC=3Dy
CONFIG_X86_MPPARSE=3Dy
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=3Dy
CONFIG_X86_CPU_RESCTRL=3Dy
CONFIG_X86_EXTENDED_PLATFORM=3Dy
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=3Dy
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=3Dy
CONFIG_X86_AMD_PLATFORM_DEVICE=3Dy
CONFIG_IOSF_MBI=3Dy
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=3Dy
CONFIG_SCHED_OMIT_FRAME_POINTER=3Dy
CONFIG_HYPERVISOR_GUEST=3Dy
CONFIG_PARAVIRT=3Dy
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=3Dy
CONFIG_X86_HV_CALLBACK_VECTOR=3Dy
CONFIG_XEN=3Dy
# CONFIG_XEN_PV is not set
CONFIG_XEN_PVHVM=3Dy
CONFIG_XEN_PVHVM_SMP=3Dy
CONFIG_XEN_SAVE_RESTORE=3Dy
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=3Dy
CONFIG_ARCH_CPUIDLE_HALTPOLL=3Dy
CONFIG_PVH=3Dy
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=3Dy
CONFIG_PARAVIRT_CLOCK=3Dy
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=3Dy
CONFIG_X86_INTERNODE_CACHE_SHIFT=3D6
CONFIG_X86_L1_CACHE_SHIFT=3D6
CONFIG_X86_TSC=3Dy
CONFIG_X86_CMPXCHG64=3Dy
CONFIG_X86_CMOV=3Dy
CONFIG_X86_MINIMUM_CPU_FAMILY=3D64
CONFIG_X86_DEBUGCTLMSR=3Dy
CONFIG_CPU_SUP_INTEL=3Dy
CONFIG_CPU_SUP_AMD=3Dy
CONFIG_CPU_SUP_HYGON=3Dy
CONFIG_CPU_SUP_CENTAUR=3Dy
CONFIG_CPU_SUP_ZHAOXIN=3Dy
CONFIG_HPET_TIMER=3Dy
CONFIG_HPET_EMULATE_RTC=3Dy
CONFIG_DMI=3Dy
# CONFIG_GART_IOMMU is not set
# CONFIG_CALGARY_IOMMU is not set
CONFIG_MAXSMP=3Dy
CONFIG_NR_CPUS_RANGE_BEGIN=3D8192
CONFIG_NR_CPUS_RANGE_END=3D8192
CONFIG_NR_CPUS_DEFAULT=3D8192
CONFIG_NR_CPUS=3D8192
CONFIG_SCHED_SMT=3Dy
CONFIG_SCHED_MC=3Dy
CONFIG_SCHED_MC_PRIO=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy
CONFIG_X86_MCE=3Dy
CONFIG_X86_MCELOG_LEGACY=3Dy
CONFIG_X86_MCE_INTEL=3Dy
CONFIG_X86_MCE_AMD=3Dy
CONFIG_X86_MCE_THRESHOLD=3Dy
CONFIG_X86_MCE_INJECT=3Dm
CONFIG_X86_THERMAL_VECTOR=3Dy

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=3Dm
CONFIG_PERF_EVENTS_INTEL_RAPL=3Dm
CONFIG_PERF_EVENTS_INTEL_CSTATE=3Dm
CONFIG_PERF_EVENTS_AMD_POWER=3Dm
# end of Performance monitoring

CONFIG_X86_16BIT=3Dy
CONFIG_X86_ESPFIX64=3Dy
CONFIG_X86_VSYSCALL_EMULATION=3Dy
CONFIG_I8K=3Dm
CONFIG_MICROCODE=3Dy
CONFIG_MICROCODE_INTEL=3Dy
CONFIG_MICROCODE_AMD=3Dy
# CONFIG_MICROCODE_OLD_INTERFACE is not set
CONFIG_X86_MSR=3Dy
CONFIG_X86_CPUID=3Dy
CONFIG_X86_5LEVEL=3Dy
CONFIG_X86_DIRECT_GBPAGES=3Dy
CONFIG_X86_CPA_STATISTICS=3Dy
CONFIG_AMD_MEM_ENCRYPT=3Dy
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=3Dy
CONFIG_AMD_NUMA=3Dy
CONFIG_X86_64_ACPI_NUMA=3Dy
CONFIG_NODES_SPAN_OTHER_NODES=3Dy
CONFIG_NUMA_EMU=3Dy
CONFIG_NODES_SHIFT=3D10
CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
CONFIG_ARCH_SPARSEMEM_DEFAULT=3Dy
CONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=3Dy
CONFIG_ILLEGAL_POINTER_VALUE=3D0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=3Dy
CONFIG_X86_PMEM_LEGACY=3Dm
CONFIG_X86_CHECK_BIOS_CORRUPTION=3Dy
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=3D64
CONFIG_MTRR=3Dy
CONFIG_MTRR_SANITIZER=3Dy
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=3D1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=3D1
CONFIG_X86_PAT=3Dy
CONFIG_ARCH_USES_PG_UNCACHED=3Dy
CONFIG_ARCH_RANDOM=3Dy
CONFIG_X86_SMAP=3Dy
CONFIG_X86_INTEL_UMIP=3Dy
# CONFIG_X86_INTEL_MPX is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=3Dy
CONFIG_X86_INTEL_TSX_MODE_OFF=3Dy
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_EFI=3Dy
CONFIG_EFI_STUB=3Dy
CONFIG_EFI_MIXED=3Dy
CONFIG_SECCOMP=3Dy
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=3Dy
CONFIG_HZ=3D1000
CONFIG_SCHED_HRTICK=3Dy
CONFIG_KEXEC=3Dy
CONFIG_KEXEC_FILE=3Dy
CONFIG_ARCH_HAS_KEXEC_PURGATORY=3Dy
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=3Dy
CONFIG_KEXEC_JUMP=3Dy
CONFIG_PHYSICAL_START=3D0x1000000
CONFIG_RELOCATABLE=3Dy
CONFIG_RANDOMIZE_BASE=3Dy
CONFIG_X86_NEED_RELOCS=3Dy
CONFIG_PHYSICAL_ALIGN=3D0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=3Dy
CONFIG_RANDOMIZE_MEMORY=3Dy
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=3D0xa
CONFIG_HOTPLUG_CPU=3Dy
CONFIG_BOOTPARAM_HOTPLUG_CPU0=3Dy
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=3Dy
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=3Dy
CONFIG_HAVE_LIVEPATCH=3Dy
CONFIG_LIVEPATCH=3Dy
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=3Dy
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=3Dy
CONFIG_USE_PERCPU_NUMA_NODE_ID=3Dy
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=3Dy
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=3Dy
CONFIG_ARCH_ENABLE_THP_MIGRATION=3Dy

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=3Dy
CONFIG_SUSPEND=3Dy
CONFIG_SUSPEND_FREEZER=3Dy
CONFIG_HIBERNATE_CALLBACKS=3Dy
CONFIG_HIBERNATION=3Dy
CONFIG_PM_STD_PARTITION=3D""
CONFIG_PM_SLEEP=3Dy
CONFIG_PM_SLEEP_SMP=3Dy
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=3Dy
CONFIG_PM_DEBUG=3Dy
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=3Dy
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=3Dy
CONFIG_PM_GENERIC_DOMAINS=3Dy
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_PM_GENERIC_DOMAINS_SLEEP=3Dy
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=3Dy
CONFIG_ACPI=3Dy
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=3Dy
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=3Dy
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=3Dy
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=3Dy
CONFIG_ACPI_LPIT=3Dy
CONFIG_ACPI_SLEEP=3Dy
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=3Dy
CONFIG_ACPI_EC_DEBUGFS=3Dm
CONFIG_ACPI_AC=3Dy
CONFIG_ACPI_BATTERY=3Dy
CONFIG_ACPI_BUTTON=3Dy
CONFIG_ACPI_VIDEO=3Dm
CONFIG_ACPI_FAN=3Dy
CONFIG_ACPI_TAD=3Dm
CONFIG_ACPI_DOCK=3Dy
CONFIG_ACPI_CPU_FREQ_PSS=3Dy
CONFIG_ACPI_PROCESSOR_CSTATE=3Dy
CONFIG_ACPI_PROCESSOR_IDLE=3Dy
CONFIG_ACPI_CPPC_LIB=3Dy
CONFIG_ACPI_PROCESSOR=3Dy
CONFIG_ACPI_IPMI=3Dm
CONFIG_ACPI_HOTPLUG_CPU=3Dy
CONFIG_ACPI_PROCESSOR_AGGREGATOR=3Dm
CONFIG_ACPI_THERMAL=3Dy
CONFIG_ACPI_NUMA=3Dy
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=3Dy
CONFIG_ACPI_TABLE_UPGRADE=3Dy
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=3Dy
CONFIG_ACPI_CONTAINER=3Dy
CONFIG_ACPI_HOTPLUG_MEMORY=3Dy
CONFIG_ACPI_HOTPLUG_IOAPIC=3Dy
CONFIG_ACPI_SBS=3Dm
CONFIG_ACPI_HED=3Dy
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=3Dy
CONFIG_ACPI_NFIT=3Dm
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_HMAT=3Dy
CONFIG_HAVE_ACPI_APEI=3Dy
CONFIG_HAVE_ACPI_APEI_NMI=3Dy
CONFIG_ACPI_APEI=3Dy
CONFIG_ACPI_APEI_GHES=3Dy
CONFIG_ACPI_APEI_PCIEAER=3Dy
CONFIG_ACPI_APEI_MEMORY_FAILURE=3Dy
CONFIG_ACPI_APEI_EINJ=3Dm
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
CONFIG_DPTF_POWER=3Dm
CONFIG_ACPI_WATCHDOG=3Dy
CONFIG_ACPI_EXTLOG=3Dm
CONFIG_ACPI_ADXL=3Dy
CONFIG_PMIC_OPREGION=3Dy
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=3Dy
CONFIG_SFI=3Dy

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_GOV_ATTR_SET=3Dy
CONFIG_CPU_FREQ_GOV_COMMON=3Dy
CONFIG_CPU_FREQ_STAT=3Dy
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dy
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=3Dy
# CONFIG_X86_PCC_CPUFREQ is not set
CONFIG_X86_ACPI_CPUFREQ=3Dm
CONFIG_X86_ACPI_CPUFREQ_CPB=3Dy
CONFIG_X86_POWERNOW_K8=3Dm
CONFIG_X86_AMD_FREQ_SENSITIVITY=3Dm
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=3Dm

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=3Dm
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=3Dy
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=3Dy
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=3Dy
CONFIG_HALTPOLL_CPUIDLE=3Dy
# end of CPU Idle

CONFIG_INTEL_IDLE=3Dy
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_MMCONFIG=3Dy
CONFIG_PCI_XEN=3Dy
CONFIG_MMCONF_FAM10H=3Dy
CONFIG_ISA_DMA_API=3Dy
CONFIG_AMD_NB=3Dy
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=3Dy
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=3Dy
CONFIG_COMPAT=3Dy
CONFIG_COMPAT_FOR_U64_ALIGNMENT=3Dy
CONFIG_SYSVIPC_COMPAT=3Dy
# end of Binary Emulations

CONFIG_X86_DEV_DMA_OPS=3Dy

#
# Firmware Drivers
#
CONFIG_EDD=3Dm
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=3Dy
CONFIG_DMIID=3Dy
CONFIG_DMI_SYSFS=3Dy
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=3Dy
CONFIG_ISCSI_IBFT_FIND=3Dy
CONFIG_ISCSI_IBFT=3Dm
CONFIG_FW_CFG_SYSFS=3Dy
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=3Dy
CONFIG_EFI_ESRT=3Dy
CONFIG_EFI_VARS_PSTORE=3Dy
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=3Dy
CONFIG_EFI_RUNTIME_MAP=3Dy
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=3Dy
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=3Dy
# CONFIG_RESET_ATTACK_MITIGATION is not set
CONFIG_EFI_RCI2_TABLE=3Dy
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=3Dy
CONFIG_UEFI_CPER_X86=3Dy
CONFIG_EFI_DEV_PATH_PARSER=3Dy
CONFIG_EFI_EARLYCON=3Dy

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=3Dy
CONFIG_HAVE_KVM_IRQCHIP=3Dy
CONFIG_HAVE_KVM_IRQFD=3Dy
CONFIG_HAVE_KVM_IRQ_ROUTING=3Dy
CONFIG_HAVE_KVM_EVENTFD=3Dy
CONFIG_KVM_MMIO=3Dy
CONFIG_KVM_ASYNC_PF=3Dy
CONFIG_HAVE_KVM_MSI=3Dy
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=3Dy
CONFIG_KVM_VFIO=3Dy
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=3Dy
CONFIG_KVM_COMPAT=3Dy
CONFIG_HAVE_KVM_IRQ_BYPASS=3Dy
CONFIG_HAVE_KVM_NO_POLL=3Dy
CONFIG_VIRTUALIZATION=3Dy
CONFIG_KVM=3Dm
CONFIG_KVM_INTEL=3Dm
CONFIG_KVM_AMD=3Dm
CONFIG_KVM_AMD_SEV=3Dy
CONFIG_KVM_MMU_AUDIT=3Dy
CONFIG_VHOST_NET=3Dm
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=3Dm
CONFIG_VHOST=3Dm
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=3Dy
CONFIG_KEXEC_CORE=3Dy
CONFIG_HOTPLUG_SMT=3Dy
CONFIG_OPROFILE=3Dm
CONFIG_OPROFILE_EVENT_MULTIPLEX=3Dy
CONFIG_HAVE_OPROFILE=3Dy
CONFIG_OPROFILE_NMI_TIMER=3Dy
CONFIG_KPROBES=3Dy
CONFIG_JUMP_LABEL=3Dy
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=3Dy
CONFIG_KPROBES_ON_FTRACE=3Dy
CONFIG_UPROBES=3Dy
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy
CONFIG_ARCH_USE_BUILTIN_BSWAP=3Dy
CONFIG_KRETPROBES=3Dy
CONFIG_USER_RETURN_NOTIFIER=3Dy
CONFIG_HAVE_IOREMAP_PROT=3Dy
CONFIG_HAVE_KPROBES=3Dy
CONFIG_HAVE_KRETPROBES=3Dy
CONFIG_HAVE_OPTPROBES=3Dy
CONFIG_HAVE_KPROBES_ON_FTRACE=3Dy
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=3Dy
CONFIG_HAVE_NMI=3Dy
CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
CONFIG_HAVE_DMA_CONTIGUOUS=3Dy
CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy
CONFIG_ARCH_HAS_FORTIFY_SOURCE=3Dy
CONFIG_ARCH_HAS_SET_MEMORY=3Dy
CONFIG_ARCH_HAS_SET_DIRECT_MAP=3Dy
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=3Dy
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=3Dy
CONFIG_HAVE_ASM_MODVERSIONS=3Dy
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy
CONFIG_HAVE_RSEQ=3Dy
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=3Dy
CONFIG_HAVE_CLK=3Dy
CONFIG_HAVE_HW_BREAKPOINT=3Dy
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=3Dy
CONFIG_HAVE_USER_RETURN_NOTIFIER=3Dy
CONFIG_HAVE_PERF_EVENTS_NMI=3Dy
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=3Dy
CONFIG_HAVE_PERF_REGS=3Dy
CONFIG_HAVE_PERF_USER_STACK_DUMP=3Dy
CONFIG_HAVE_ARCH_JUMP_LABEL=3Dy
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=3Dy
CONFIG_HAVE_RCU_TABLE_FREE=3Dy
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=3Dy
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=3Dy
CONFIG_HAVE_CMPXCHG_LOCAL=3Dy
CONFIG_HAVE_CMPXCHG_DOUBLE=3Dy
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=3Dy
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=3Dy
CONFIG_HAVE_ARCH_SECCOMP_FILTER=3Dy
CONFIG_SECCOMP_FILTER=3Dy
CONFIG_HAVE_ARCH_STACKLEAK=3Dy
CONFIG_HAVE_STACKPROTECTOR=3Dy
CONFIG_CC_HAS_STACKPROTECTOR_NONE=3Dy
CONFIG_STACKPROTECTOR=3Dy
CONFIG_STACKPROTECTOR_STRONG=3Dy
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=3Dy
CONFIG_HAVE_CONTEXT_TRACKING=3Dy
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=3Dy
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=3Dy
CONFIG_HAVE_MOVE_PMD=3Dy
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=3Dy
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=3Dy
CONFIG_HAVE_ARCH_HUGE_VMAP=3Dy
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=3Dy
CONFIG_HAVE_ARCH_SOFT_DIRTY=3Dy
CONFIG_HAVE_MOD_ARCH_SPECIFIC=3Dy
CONFIG_MODULES_USE_ELF_RELA=3Dy
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=3Dy
CONFIG_ARCH_HAS_ELF_RANDOMIZE=3Dy
CONFIG_HAVE_ARCH_MMAP_RND_BITS=3Dy
CONFIG_HAVE_EXIT_THREAD=3Dy
CONFIG_ARCH_MMAP_RND_BITS=3D28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=3Dy
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=3D8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=3Dy
CONFIG_HAVE_COPY_THREAD_TLS=3Dy
CONFIG_HAVE_STACK_VALIDATION=3Dy
CONFIG_HAVE_RELIABLE_STACKTRACE=3Dy
CONFIG_OLD_SIGSUSPEND3=3Dy
CONFIG_COMPAT_OLD_SIGACTION=3Dy
CONFIG_64BIT_TIME=3Dy
CONFIG_COMPAT_32BIT_TIME=3Dy
CONFIG_HAVE_ARCH_VMAP_STACK=3Dy
CONFIG_VMAP_STACK=3Dy
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=3Dy
CONFIG_STRICT_KERNEL_RWX=3Dy
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=3Dy
CONFIG_STRICT_MODULE_RWX=3Dy
CONFIG_ARCH_HAS_REFCOUNT=3Dy
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=3Dy
CONFIG_ARCH_USE_MEMREMAP_PROT=3Dy
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=3Dy

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=3Dy
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC=3D""
CONFIG_HAVE_GCC_PLUGINS=3Dy
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=3Dy
CONFIG_BASE_SMALL=3D0
CONFIG_MODULE_SIG_FORMAT=3Dy
CONFIG_MODULES=3Dy
CONFIG_MODULE_FORCE_LOAD=3Dy
CONFIG_MODULE_UNLOAD=3Dy
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_MODVERSIONS=3Dy
CONFIG_ASM_MODVERSIONS=3Dy
CONFIG_MODULE_SRCVERSION_ALL=3Dy
CONFIG_MODULE_SIG=3Dy
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=3Dy
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=3Dy
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH=3D"sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=3Dy
CONFIG_BLOCK=3Dy
CONFIG_BLK_SCSI_REQUEST=3Dy
CONFIG_BLK_DEV_BSG=3Dy
CONFIG_BLK_DEV_BSGLIB=3Dy
CONFIG_BLK_DEV_INTEGRITY=3Dy
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=3Dy
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=3Dy
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_WBT_MQ=3Dy
CONFIG_BLK_DEBUG_FS=3Dy
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=3Dy
CONFIG_AMIGA_PARTITION=3Dy
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=3Dy
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_BSD_DISKLABEL=3Dy
CONFIG_MINIX_SUBPARTITION=3Dy
CONFIG_SOLARIS_X86_PARTITION=3Dy
CONFIG_UNIXWARE_DISKLABEL=3Dy
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=3Dy
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=3Dy
CONFIG_KARMA_PARTITION=3Dy
CONFIG_EFI_PARTITION=3Dy
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=3Dy
CONFIG_BLK_MQ_PCI=3Dy
CONFIG_BLK_MQ_VIRTIO=3Dy
CONFIG_BLK_MQ_RDMA=3Dy
CONFIG_BLK_PM=3Dy

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=3Dy
CONFIG_MQ_IOSCHED_KYBER=3Dy
CONFIG_IOSCHED_BFQ=3Dy
CONFIG_BFQ_GROUP_IOSCHED=3Dy
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=3Dy
CONFIG_PADATA=3Dy
CONFIG_ASN1=3Dy
CONFIG_INLINE_SPIN_UNLOCK_IRQ=3Dy
CONFIG_INLINE_READ_UNLOCK=3Dy
CONFIG_INLINE_READ_UNLOCK_IRQ=3Dy
CONFIG_INLINE_WRITE_UNLOCK=3Dy
CONFIG_INLINE_WRITE_UNLOCK_IRQ=3Dy
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dy
CONFIG_MUTEX_SPIN_ON_OWNER=3Dy
CONFIG_RWSEM_SPIN_ON_OWNER=3Dy
CONFIG_LOCK_SPIN_ON_OWNER=3Dy
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=3Dy
CONFIG_QUEUED_SPINLOCKS=3Dy
CONFIG_ARCH_USE_QUEUED_RWLOCKS=3Dy
CONFIG_QUEUED_RWLOCKS=3Dy
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=3Dy
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=3Dy
CONFIG_FREEZER=3Dy

#
# Executable file formats
#
CONFIG_BINFMT_ELF=3Dy
CONFIG_COMPAT_BINFMT_ELF=3Dy
CONFIG_ELFCORE=3Dy
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
CONFIG_BINFMT_SCRIPT=3Dy
CONFIG_BINFMT_MISC=3Dm
CONFIG_COREDUMP=3Dy
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=3Dy
CONFIG_SPARSEMEM_MANUAL=3Dy
CONFIG_SPARSEMEM=3Dy
CONFIG_NEED_MULTIPLE_NODES=3Dy
CONFIG_HAVE_MEMORY_PRESENT=3Dy
CONFIG_SPARSEMEM_EXTREME=3Dy
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy
CONFIG_SPARSEMEM_VMEMMAP=3Dy
CONFIG_HAVE_MEMBLOCK_NODE_MAP=3Dy
CONFIG_HAVE_FAST_GUP=3Dy
CONFIG_MEMORY_ISOLATION=3Dy
CONFIG_HAVE_BOOTMEM_INFO_NODE=3Dy
CONFIG_MEMORY_HOTPLUG=3Dy
CONFIG_MEMORY_HOTPLUG_SPARSE=3Dy
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=3Dy
CONFIG_SPLIT_PTLOCK_CPUS=3D4
CONFIG_MEMORY_BALLOON=3Dy
CONFIG_BALLOON_COMPACTION=3Dy
CONFIG_COMPACTION=3Dy
CONFIG_MIGRATION=3Dy
CONFIG_CONTIG_ALLOC=3Dy
CONFIG_PHYS_ADDR_T_64BIT=3Dy
CONFIG_BOUNCE=3Dy
CONFIG_VIRT_TO_BUS=3Dy
CONFIG_MMU_NOTIFIER=3Dy
CONFIG_KSM=3Dy
CONFIG_DEFAULT_MMAP_MIN_ADDR=3D65536
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=3Dy
CONFIG_MEMORY_FAILURE=3Dy
CONFIG_HWPOISON_INJECT=3Dm
CONFIG_TRANSPARENT_HUGEPAGE=3Dy
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=3Dy
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=3Dy
CONFIG_THP_SWAP=3Dy
CONFIG_TRANSPARENT_HUGE_PAGECACHE=3Dy
CONFIG_CLEANCACHE=3Dy
CONFIG_FRONTSWAP=3Dy
# CONFIG_CMA is not set
CONFIG_MEM_SOFT_DIRTY=3Dy
CONFIG_ZSWAP=3Dy
CONFIG_ZPOOL=3Dy
CONFIG_ZBUD=3Dy
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=3Dy
# CONFIG_PGTABLE_MAPPING is not set
CONFIG_ZSMALLOC_STAT=3Dy
CONFIG_GENERIC_EARLY_IOREMAP=3Dy
CONFIG_DEFERRED_STRUCT_PAGE_INIT=3Dy
CONFIG_IDLE_PAGE_TRACKING=3Dy
CONFIG_ARCH_HAS_PTE_DEVMAP=3Dy
CONFIG_ZONE_DEVICE=3Dy
CONFIG_DEV_PAGEMAP_OPS=3Dy
CONFIG_DEVICE_PRIVATE=3Dy
CONFIG_FRAME_VECTOR=3Dy
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=3Dy
CONFIG_ARCH_HAS_PKEYS=3Dy
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=3Dy
# end of Memory Management options

CONFIG_NET=3Dy
CONFIG_NET_INGRESS=3Dy
CONFIG_NET_EGRESS=3Dy
CONFIG_SKB_EXTENSIONS=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
CONFIG_PACKET_DIAG=3Dm
CONFIG_UNIX=3Dy
CONFIG_UNIX_SCM=3Dy
CONFIG_UNIX_DIAG=3Dm
CONFIG_TLS=3Dm
CONFIG_TLS_DEVICE=3Dy
CONFIG_XFRM=3Dy
CONFIG_XFRM_OFFLOAD=3Dy
CONFIG_XFRM_ALGO=3Dy
CONFIG_XFRM_USER=3Dy
CONFIG_XFRM_INTERFACE=3Dm
CONFIG_XFRM_SUB_POLICY=3Dy
CONFIG_XFRM_MIGRATE=3Dy
CONFIG_XFRM_STATISTICS=3Dy
CONFIG_XFRM_IPCOMP=3Dm
CONFIG_NET_KEY=3Dm
CONFIG_NET_KEY_MIGRATE=3Dy
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=3Dy
CONFIG_XDP_SOCKETS_DIAG=3Dm
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_IP_ADVANCED_ROUTER=3Dy
CONFIG_IP_FIB_TRIE_STATS=3Dy
CONFIG_IP_MULTIPLE_TABLES=3Dy
CONFIG_IP_ROUTE_MULTIPATH=3Dy
CONFIG_IP_ROUTE_VERBOSE=3Dy
CONFIG_IP_ROUTE_CLASSID=3Dy
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=3Dm
CONFIG_NET_IPGRE_DEMUX=3Dm
CONFIG_NET_IP_TUNNEL=3Dm
CONFIG_NET_IPGRE=3Dm
CONFIG_NET_IPGRE_BROADCAST=3Dy
CONFIG_IP_MROUTE_COMMON=3Dy
CONFIG_IP_MROUTE=3Dy
CONFIG_IP_MROUTE_MULTIPLE_TABLES=3Dy
CONFIG_IP_PIMSM_V1=3Dy
CONFIG_IP_PIMSM_V2=3Dy
CONFIG_SYN_COOKIES=3Dy
CONFIG_NET_IPVTI=3Dm
CONFIG_NET_UDP_TUNNEL=3Dm
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=3Dm
CONFIG_INET_ESP=3Dm
CONFIG_INET_ESP_OFFLOAD=3Dm
CONFIG_INET_IPCOMP=3Dm
CONFIG_INET_XFRM_TUNNEL=3Dm
CONFIG_INET_TUNNEL=3Dm
CONFIG_INET_DIAG=3Dm
CONFIG_INET_TCP_DIAG=3Dm
CONFIG_INET_UDP_DIAG=3Dm
CONFIG_INET_RAW_DIAG=3Dm
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=3Dy
CONFIG_TCP_CONG_BIC=3Dm
CONFIG_TCP_CONG_CUBIC=3Dy
CONFIG_TCP_CONG_WESTWOOD=3Dm
CONFIG_TCP_CONG_HTCP=3Dm
CONFIG_TCP_CONG_HSTCP=3Dm
CONFIG_TCP_CONG_HYBLA=3Dm
CONFIG_TCP_CONG_VEGAS=3Dm
CONFIG_TCP_CONG_NV=3Dm
CONFIG_TCP_CONG_SCALABLE=3Dm
CONFIG_TCP_CONG_LP=3Dm
CONFIG_TCP_CONG_VENO=3Dm
CONFIG_TCP_CONG_YEAH=3Dm
CONFIG_TCP_CONG_ILLINOIS=3Dm
CONFIG_TCP_CONG_DCTCP=3Dm
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=3Dm
CONFIG_DEFAULT_CUBIC=3Dy
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG=3D"cubic"
CONFIG_TCP_MD5SIG=3Dy
CONFIG_IPV6=3Dy
CONFIG_IPV6_ROUTER_PREF=3Dy
CONFIG_IPV6_ROUTE_INFO=3Dy
CONFIG_IPV6_OPTIMISTIC_DAD=3Dy
CONFIG_INET6_AH=3Dm
CONFIG_INET6_ESP=3Dm
CONFIG_INET6_ESP_OFFLOAD=3Dm
CONFIG_INET6_IPCOMP=3Dm
CONFIG_IPV6_MIP6=3Dm
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=3Dm
CONFIG_INET6_TUNNEL=3Dm
CONFIG_IPV6_VTI=3Dm
CONFIG_IPV6_SIT=3Dm
CONFIG_IPV6_SIT_6RD=3Dy
CONFIG_IPV6_NDISC_NODETYPE=3Dy
CONFIG_IPV6_TUNNEL=3Dm
CONFIG_IPV6_GRE=3Dm
CONFIG_IPV6_MULTIPLE_TABLES=3Dy
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=3Dy
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=3Dy
CONFIG_IPV6_PIMSM_V2=3Dy
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_NETLABEL=3Dy
CONFIG_NETWORK_SECMARK=3Dy
CONFIG_NET_PTP_CLASSIFY=3Dy
CONFIG_NETWORK_PHY_TIMESTAMPING=3Dy
CONFIG_NETFILTER=3Dy
CONFIG_NETFILTER_ADVANCED=3Dy
CONFIG_BRIDGE_NETFILTER=3Dm

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=3Dy
CONFIG_NETFILTER_NETLINK=3Dm
CONFIG_NETFILTER_FAMILY_BRIDGE=3Dy
CONFIG_NETFILTER_FAMILY_ARP=3Dy
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=3Dm
CONFIG_NETFILTER_NETLINK_LOG=3Dm
CONFIG_NETFILTER_NETLINK_OSF=3Dm
CONFIG_NF_CONNTRACK=3Dm
CONFIG_NF_LOG_COMMON=3Dm
CONFIG_NF_LOG_NETDEV=3Dm
CONFIG_NETFILTER_CONNCOUNT=3Dm
CONFIG_NF_CONNTRACK_MARK=3Dy
CONFIG_NF_CONNTRACK_SECMARK=3Dy
CONFIG_NF_CONNTRACK_ZONES=3Dy
CONFIG_NF_CONNTRACK_PROCFS=3Dy
CONFIG_NF_CONNTRACK_EVENTS=3Dy
CONFIG_NF_CONNTRACK_TIMEOUT=3Dy
CONFIG_NF_CONNTRACK_TIMESTAMP=3Dy
CONFIG_NF_CONNTRACK_LABELS=3Dy
CONFIG_NF_CT_PROTO_DCCP=3Dy
CONFIG_NF_CT_PROTO_GRE=3Dy
CONFIG_NF_CT_PROTO_SCTP=3Dy
CONFIG_NF_CT_PROTO_UDPLITE=3Dy
CONFIG_NF_CONNTRACK_AMANDA=3Dm
CONFIG_NF_CONNTRACK_FTP=3Dm
CONFIG_NF_CONNTRACK_H323=3Dm
CONFIG_NF_CONNTRACK_IRC=3Dm
CONFIG_NF_CONNTRACK_BROADCAST=3Dm
CONFIG_NF_CONNTRACK_NETBIOS_NS=3Dm
CONFIG_NF_CONNTRACK_SNMP=3Dm
CONFIG_NF_CONNTRACK_PPTP=3Dm
CONFIG_NF_CONNTRACK_SANE=3Dm
CONFIG_NF_CONNTRACK_SIP=3Dm
CONFIG_NF_CONNTRACK_TFTP=3Dm
CONFIG_NF_CT_NETLINK=3Dm
CONFIG_NF_CT_NETLINK_TIMEOUT=3Dm
CONFIG_NF_CT_NETLINK_HELPER=3Dm
CONFIG_NETFILTER_NETLINK_GLUE_CT=3Dy
CONFIG_NF_NAT=3Dm
CONFIG_NF_NAT_AMANDA=3Dm
CONFIG_NF_NAT_FTP=3Dm
CONFIG_NF_NAT_IRC=3Dm
CONFIG_NF_NAT_SIP=3Dm
CONFIG_NF_NAT_TFTP=3Dm
CONFIG_NF_NAT_REDIRECT=3Dy
CONFIG_NF_NAT_MASQUERADE=3Dy
CONFIG_NETFILTER_SYNPROXY=3Dm
CONFIG_NF_TABLES=3Dm
CONFIG_NF_TABLES_SET=3Dm
CONFIG_NF_TABLES_INET=3Dy
CONFIG_NF_TABLES_NETDEV=3Dy
CONFIG_NFT_NUMGEN=3Dm
CONFIG_NFT_CT=3Dm
CONFIG_NFT_COUNTER=3Dm
CONFIG_NFT_CONNLIMIT=3Dm
CONFIG_NFT_LOG=3Dm
CONFIG_NFT_LIMIT=3Dm
CONFIG_NFT_MASQ=3Dm
CONFIG_NFT_REDIR=3Dm
CONFIG_NFT_NAT=3Dm
CONFIG_NFT_TUNNEL=3Dm
CONFIG_NFT_OBJREF=3Dm
CONFIG_NFT_QUEUE=3Dm
CONFIG_NFT_QUOTA=3Dm
CONFIG_NFT_REJECT=3Dm
CONFIG_NFT_REJECT_INET=3Dm
CONFIG_NFT_COMPAT=3Dm
CONFIG_NFT_HASH=3Dm
CONFIG_NFT_FIB=3Dm
CONFIG_NFT_FIB_INET=3Dm
CONFIG_NFT_XFRM=3Dm
CONFIG_NFT_SOCKET=3Dm
CONFIG_NFT_OSF=3Dm
CONFIG_NFT_TPROXY=3Dm
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=3Dm
CONFIG_NFT_DUP_NETDEV=3Dm
CONFIG_NFT_FWD_NETDEV=3Dm
CONFIG_NFT_FIB_NETDEV=3Dm
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=3Dy

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=3Dm
CONFIG_NETFILTER_XT_CONNMARK=3Dm
CONFIG_NETFILTER_XT_SET=3Dm

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=3Dm
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=3Dm
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dm
CONFIG_NETFILTER_XT_TARGET_CONNMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_CT=3Dm
CONFIG_NETFILTER_XT_TARGET_DSCP=3Dm
CONFIG_NETFILTER_XT_TARGET_HL=3Dm
CONFIG_NETFILTER_XT_TARGET_HMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=3Dm
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=3Dm
CONFIG_NETFILTER_XT_TARGET_MARK=3Dm
CONFIG_NETFILTER_XT_NAT=3Dm
CONFIG_NETFILTER_XT_TARGET_NETMAP=3Dm
CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dm
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dm
CONFIG_NETFILTER_XT_TARGET_NOTRACK=3Dm
CONFIG_NETFILTER_XT_TARGET_RATEEST=3Dm
CONFIG_NETFILTER_XT_TARGET_REDIRECT=3Dm
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=3Dm
CONFIG_NETFILTER_XT_TARGET_TEE=3Dm
CONFIG_NETFILTER_XT_TARGET_TPROXY=3Dm
CONFIG_NETFILTER_XT_TARGET_TRACE=3Dm
CONFIG_NETFILTER_XT_TARGET_SECMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dm
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=3Dm

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=3Dm
CONFIG_NETFILTER_XT_MATCH_BPF=3Dm
CONFIG_NETFILTER_XT_MATCH_CGROUP=3Dm
CONFIG_NETFILTER_XT_MATCH_CLUSTER=3Dm
CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNMARK=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dm
CONFIG_NETFILTER_XT_MATCH_CPU=3Dm
CONFIG_NETFILTER_XT_MATCH_DCCP=3Dm
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=3Dm
CONFIG_NETFILTER_XT_MATCH_DSCP=3Dm
CONFIG_NETFILTER_XT_MATCH_ECN=3Dm
CONFIG_NETFILTER_XT_MATCH_ESP=3Dm
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=3Dm
CONFIG_NETFILTER_XT_MATCH_HELPER=3Dm
CONFIG_NETFILTER_XT_MATCH_HL=3Dm
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=3Dm
CONFIG_NETFILTER_XT_MATCH_IPVS=3Dm
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dm
CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dm
CONFIG_NETFILTER_XT_MATCH_MAC=3Dm
CONFIG_NETFILTER_XT_MATCH_MARK=3Dm
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=3Dm
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=3Dm
CONFIG_NETFILTER_XT_MATCH_OWNER=3Dm
CONFIG_NETFILTER_XT_MATCH_POLICY=3Dm
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=3Dm
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dm
CONFIG_NETFILTER_XT_MATCH_QUOTA=3Dm
CONFIG_NETFILTER_XT_MATCH_RATEEST=3Dm
CONFIG_NETFILTER_XT_MATCH_REALM=3Dm
CONFIG_NETFILTER_XT_MATCH_RECENT=3Dm
CONFIG_NETFILTER_XT_MATCH_SCTP=3Dm
CONFIG_NETFILTER_XT_MATCH_SOCKET=3Dm
CONFIG_NETFILTER_XT_MATCH_STATE=3Dm
CONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dm
CONFIG_NETFILTER_XT_MATCH_STRING=3Dm
CONFIG_NETFILTER_XT_MATCH_TCPMSS=3Dm
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=3Dm
CONFIG_IP_SET_MAX=3D256
CONFIG_IP_SET_BITMAP_IP=3Dm
CONFIG_IP_SET_BITMAP_IPMAC=3Dm
CONFIG_IP_SET_BITMAP_PORT=3Dm
CONFIG_IP_SET_HASH_IP=3Dm
CONFIG_IP_SET_HASH_IPMARK=3Dm
CONFIG_IP_SET_HASH_IPPORT=3Dm
CONFIG_IP_SET_HASH_IPPORTIP=3Dm
CONFIG_IP_SET_HASH_IPPORTNET=3Dm
CONFIG_IP_SET_HASH_IPMAC=3Dm
CONFIG_IP_SET_HASH_MAC=3Dm
CONFIG_IP_SET_HASH_NETPORTNET=3Dm
CONFIG_IP_SET_HASH_NET=3Dm
CONFIG_IP_SET_HASH_NETNET=3Dm
CONFIG_IP_SET_HASH_NETPORT=3Dm
CONFIG_IP_SET_HASH_NETIFACE=3Dm
CONFIG_IP_SET_LIST_SET=3Dm
CONFIG_IP_VS=3Dm
CONFIG_IP_VS_IPV6=3Dy
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=3D12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=3Dy
CONFIG_IP_VS_PROTO_UDP=3Dy
CONFIG_IP_VS_PROTO_AH_ESP=3Dy
CONFIG_IP_VS_PROTO_ESP=3Dy
CONFIG_IP_VS_PROTO_AH=3Dy
CONFIG_IP_VS_PROTO_SCTP=3Dy

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=3Dm
CONFIG_IP_VS_WRR=3Dm
CONFIG_IP_VS_LC=3Dm
CONFIG_IP_VS_WLC=3Dm
CONFIG_IP_VS_FO=3Dm
CONFIG_IP_VS_OVF=3Dm
CONFIG_IP_VS_LBLC=3Dm
CONFIG_IP_VS_LBLCR=3Dm
CONFIG_IP_VS_DH=3Dm
CONFIG_IP_VS_SH=3Dm
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=3Dm
CONFIG_IP_VS_NQ=3Dm

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=3D8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=3D12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=3Dm
CONFIG_IP_VS_NFCT=3Dy
CONFIG_IP_VS_PE_SIP=3Dm

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=3Dm
CONFIG_NF_SOCKET_IPV4=3Dm
CONFIG_NF_TPROXY_IPV4=3Dm
CONFIG_NF_TABLES_IPV4=3Dy
CONFIG_NFT_REJECT_IPV4=3Dm
CONFIG_NFT_DUP_IPV4=3Dm
CONFIG_NFT_FIB_IPV4=3Dm
CONFIG_NF_TABLES_ARP=3Dy
CONFIG_NF_DUP_IPV4=3Dm
CONFIG_NF_LOG_ARP=3Dm
CONFIG_NF_LOG_IPV4=3Dm
CONFIG_NF_REJECT_IPV4=3Dm
CONFIG_NF_NAT_SNMP_BASIC=3Dm
CONFIG_NF_NAT_PPTP=3Dm
CONFIG_NF_NAT_H323=3Dm
CONFIG_IP_NF_IPTABLES=3Dm
CONFIG_IP_NF_MATCH_AH=3Dm
CONFIG_IP_NF_MATCH_ECN=3Dm
CONFIG_IP_NF_MATCH_RPFILTER=3Dm
CONFIG_IP_NF_MATCH_TTL=3Dm
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_TARGET_SYNPROXY=3Dm
CONFIG_IP_NF_NAT=3Dm
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP_NF_TARGET_NETMAP=3Dm
CONFIG_IP_NF_TARGET_REDIRECT=3Dm
CONFIG_IP_NF_MANGLE=3Dm
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=3Dm
CONFIG_IP_NF_TARGET_TTL=3Dm
CONFIG_IP_NF_RAW=3Dm
CONFIG_IP_NF_SECURITY=3Dm
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_IP_NF_ARPFILTER=3Dm
CONFIG_IP_NF_ARP_MANGLE=3Dm
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=3Dm
CONFIG_NF_TPROXY_IPV6=3Dm
CONFIG_NF_TABLES_IPV6=3Dy
CONFIG_NFT_REJECT_IPV6=3Dm
CONFIG_NFT_DUP_IPV6=3Dm
CONFIG_NFT_FIB_IPV6=3Dm
CONFIG_NF_DUP_IPV6=3Dm
CONFIG_NF_REJECT_IPV6=3Dm
CONFIG_NF_LOG_IPV6=3Dm
CONFIG_IP6_NF_IPTABLES=3Dm
CONFIG_IP6_NF_MATCH_AH=3Dm
CONFIG_IP6_NF_MATCH_EUI64=3Dm
CONFIG_IP6_NF_MATCH_FRAG=3Dm
CONFIG_IP6_NF_MATCH_OPTS=3Dm
CONFIG_IP6_NF_MATCH_HL=3Dm
CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dm
CONFIG_IP6_NF_MATCH_MH=3Dm
CONFIG_IP6_NF_MATCH_RPFILTER=3Dm
CONFIG_IP6_NF_MATCH_RT=3Dm
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=3Dm
CONFIG_IP6_NF_TARGET_REJECT=3Dm
CONFIG_IP6_NF_TARGET_SYNPROXY=3Dm
CONFIG_IP6_NF_MANGLE=3Dm
CONFIG_IP6_NF_RAW=3Dm
CONFIG_IP6_NF_SECURITY=3Dm
CONFIG_IP6_NF_NAT=3Dm
CONFIG_IP6_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP6_NF_TARGET_NPT=3Dm
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=3Dm
CONFIG_NF_TABLES_BRIDGE=3Dm
CONFIG_NFT_BRIDGE_META=3Dm
CONFIG_NFT_BRIDGE_REJECT=3Dm
CONFIG_NF_LOG_BRIDGE=3Dm
CONFIG_NF_CONNTRACK_BRIDGE=3Dm
CONFIG_BRIDGE_NF_EBTABLES=3Dm
CONFIG_BRIDGE_EBT_BROUTE=3Dm
CONFIG_BRIDGE_EBT_T_FILTER=3Dm
CONFIG_BRIDGE_EBT_T_NAT=3Dm
CONFIG_BRIDGE_EBT_802_3=3Dm
CONFIG_BRIDGE_EBT_AMONG=3Dm
CONFIG_BRIDGE_EBT_ARP=3Dm
CONFIG_BRIDGE_EBT_IP=3Dm
CONFIG_BRIDGE_EBT_IP6=3Dm
CONFIG_BRIDGE_EBT_LIMIT=3Dm
CONFIG_BRIDGE_EBT_MARK=3Dm
CONFIG_BRIDGE_EBT_PKTTYPE=3Dm
CONFIG_BRIDGE_EBT_STP=3Dm
CONFIG_BRIDGE_EBT_VLAN=3Dm
CONFIG_BRIDGE_EBT_ARPREPLY=3Dm
CONFIG_BRIDGE_EBT_DNAT=3Dm
CONFIG_BRIDGE_EBT_MARK_T=3Dm
CONFIG_BRIDGE_EBT_REDIRECT=3Dm
CONFIG_BRIDGE_EBT_SNAT=3Dm
CONFIG_BRIDGE_EBT_LOG=3Dm
CONFIG_BRIDGE_EBT_NFLOG=3Dm
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=3Dm
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=3Dy
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=3Dy
CONFIG_SCTP_COOKIE_HMAC_SHA1=3Dy
CONFIG_INET_SCTP_DIAG=3Dm
# CONFIG_RDS is not set
CONFIG_TIPC=3Dm
CONFIG_TIPC_MEDIA_IB=3Dy
CONFIG_TIPC_MEDIA_UDP=3Dy
CONFIG_TIPC_DIAG=3Dm
CONFIG_ATM=3Dm
CONFIG_ATM_CLIP=3Dm
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=3Dm
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=3Dm
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=3Dm
CONFIG_L2TP_DEBUGFS=3Dm
CONFIG_L2TP_V3=3Dy
CONFIG_L2TP_IP=3Dm
CONFIG_L2TP_ETH=3Dm
CONFIG_STP=3Dm
CONFIG_GARP=3Dm
CONFIG_MRP=3Dm
CONFIG_BRIDGE=3Dm
CONFIG_BRIDGE_IGMP_SNOOPING=3Dy
CONFIG_BRIDGE_VLAN_FILTERING=3Dy
CONFIG_HAVE_NET_DSA=3Dy
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=3Dm
CONFIG_VLAN_8021Q_GVRP=3Dy
CONFIG_VLAN_8021Q_MVRP=3Dy
# CONFIG_DECNET is not set
CONFIG_LLC=3Dm
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=3Dm
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=3Dm
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=3Dm
CONFIG_IEEE802154_6LOWPAN=3Dm
CONFIG_MAC802154=3Dm
CONFIG_NET_SCHED=3Dy

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=3Dm
CONFIG_NET_SCH_HTB=3Dm
CONFIG_NET_SCH_HFSC=3Dm
CONFIG_NET_SCH_ATM=3Dm
CONFIG_NET_SCH_PRIO=3Dm
CONFIG_NET_SCH_MULTIQ=3Dm
CONFIG_NET_SCH_RED=3Dm
CONFIG_NET_SCH_SFB=3Dm
CONFIG_NET_SCH_SFQ=3Dm
CONFIG_NET_SCH_TEQL=3Dm
CONFIG_NET_SCH_TBF=3Dm
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=3Dm
CONFIG_NET_SCH_DSMARK=3Dm
CONFIG_NET_SCH_NETEM=3Dm
CONFIG_NET_SCH_DRR=3Dm
CONFIG_NET_SCH_MQPRIO=3Dm
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=3Dm
CONFIG_NET_SCH_QFQ=3Dm
CONFIG_NET_SCH_CODEL=3Dm
CONFIG_NET_SCH_FQ_CODEL=3Dy
CONFIG_NET_SCH_CAKE=3Dm
CONFIG_NET_SCH_FQ=3Dm
CONFIG_NET_SCH_HHF=3Dm
CONFIG_NET_SCH_PIE=3Dm
CONFIG_NET_SCH_INGRESS=3Dm
CONFIG_NET_SCH_PLUG=3Dm
CONFIG_NET_SCH_DEFAULT=3Dy
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=3Dy
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH=3D"fq_codel"

#
# Classification
#
CONFIG_NET_CLS=3Dy
CONFIG_NET_CLS_BASIC=3Dm
CONFIG_NET_CLS_TCINDEX=3Dm
CONFIG_NET_CLS_ROUTE4=3Dm
CONFIG_NET_CLS_FW=3Dm
CONFIG_NET_CLS_U32=3Dm
CONFIG_CLS_U32_PERF=3Dy
CONFIG_CLS_U32_MARK=3Dy
CONFIG_NET_CLS_RSVP=3Dm
CONFIG_NET_CLS_RSVP6=3Dm
CONFIG_NET_CLS_FLOW=3Dm
CONFIG_NET_CLS_CGROUP=3Dy
CONFIG_NET_CLS_BPF=3Dm
CONFIG_NET_CLS_FLOWER=3Dm
CONFIG_NET_CLS_MATCHALL=3Dm
CONFIG_NET_EMATCH=3Dy
CONFIG_NET_EMATCH_STACK=3D32
CONFIG_NET_EMATCH_CMP=3Dm
CONFIG_NET_EMATCH_NBYTE=3Dm
CONFIG_NET_EMATCH_U32=3Dm
CONFIG_NET_EMATCH_META=3Dm
CONFIG_NET_EMATCH_TEXT=3Dm
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=3Dm
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=3Dy
CONFIG_NET_ACT_POLICE=3Dm
CONFIG_NET_ACT_GACT=3Dm
CONFIG_GACT_PROB=3Dy
CONFIG_NET_ACT_MIRRED=3Dm
CONFIG_NET_ACT_SAMPLE=3Dm
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=3Dm
CONFIG_NET_ACT_PEDIT=3Dm
CONFIG_NET_ACT_SIMP=3Dm
CONFIG_NET_ACT_SKBEDIT=3Dm
CONFIG_NET_ACT_CSUM=3Dm
CONFIG_NET_ACT_MPLS=3Dm
CONFIG_NET_ACT_VLAN=3Dm
CONFIG_NET_ACT_BPF=3Dm
# CONFIG_NET_ACT_CONNMARK is not set
CONFIG_NET_ACT_CTINFO=3Dm
CONFIG_NET_ACT_SKBMOD=3Dm
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=3Dm
CONFIG_NET_ACT_CT=3Dm
CONFIG_NET_TC_SKB_EXT=3Dy
CONFIG_NET_SCH_FIFO=3Dy
CONFIG_DCB=3Dy
CONFIG_DNS_RESOLVER=3Dm
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=3Dm
CONFIG_OPENVSWITCH_GRE=3Dm
CONFIG_OPENVSWITCH_VXLAN=3Dm
CONFIG_OPENVSWITCH_GENEVE=3Dm
CONFIG_VSOCKETS=3Dm
CONFIG_VSOCKETS_DIAG=3Dm
CONFIG_VMWARE_VMCI_VSOCKETS=3Dm
CONFIG_VIRTIO_VSOCKETS=3Dm
CONFIG_VIRTIO_VSOCKETS_COMMON=3Dm
CONFIG_HYPERV_VSOCKETS=3Dm
CONFIG_NETLINK_DIAG=3Dm
CONFIG_MPLS=3Dy
CONFIG_NET_MPLS_GSO=3Dy
# CONFIG_MPLS_ROUTING is not set
CONFIG_NET_NSH=3Dy
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=3Dy
CONFIG_NET_L3_MASTER_DEV=3Dy
# CONFIG_NET_NCSI is not set
CONFIG_RPS=3Dy
CONFIG_RFS_ACCEL=3Dy
CONFIG_XPS=3Dy
CONFIG_CGROUP_NET_PRIO=3Dy
CONFIG_CGROUP_NET_CLASSID=3Dy
CONFIG_NET_RX_BUSY_POLL=3Dy
CONFIG_BQL=3Dy
CONFIG_BPF_JIT=3Dy
# CONFIG_BPF_STREAM_PARSER is not set
CONFIG_NET_FLOW_LIMIT=3Dy

#
# Network testing
#
CONFIG_NET_PKTGEN=3Dm
CONFIG_NET_DROP_MONITOR=3Dy
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=3Dm
CONFIG_CAN_RAW=3Dm
CONFIG_CAN_BCM=3Dm
CONFIG_CAN_GW=3Dm
# CONFIG_CAN_J1939 is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=3Dm
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=3Dm
CONFIG_CAN_DEV=3Dm
CONFIG_CAN_CALC_BITTIMING=3Dy
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=3Dm
CONFIG_CAN_C_CAN_PLATFORM=3Dm
CONFIG_CAN_C_CAN_PCI=3Dm
CONFIG_CAN_CC770=3Dm
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=3Dm
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=3Dm
CONFIG_CAN_EMS_PCI=3Dm
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=3Dm
CONFIG_CAN_PEAK_PCI=3Dm
CONFIG_CAN_PEAK_PCIEC=3Dy
CONFIG_CAN_PLX_PCI=3Dm
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=3Dm
CONFIG_CAN_SOFTING=3Dm

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=3Dm
CONFIG_CAN_EMS_USB=3Dm
CONFIG_CAN_ESD_USB2=3Dm
# CONFIG_CAN_GS_USB is not set
CONFIG_CAN_KVASER_USB=3Dm
# CONFIG_CAN_MCBA_USB is not set
CONFIG_CAN_PEAK_USB=3Dm
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=3Dm
CONFIG_BT_BREDR=3Dy
CONFIG_BT_RFCOMM=3Dm
CONFIG_BT_RFCOMM_TTY=3Dy
CONFIG_BT_BNEP=3Dm
CONFIG_BT_BNEP_MC_FILTER=3Dy
CONFIG_BT_BNEP_PROTO_FILTER=3Dy
CONFIG_BT_HIDP=3Dm
CONFIG_BT_HS=3Dy
CONFIG_BT_LE=3Dy
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=3Dy

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=3Dm
CONFIG_BT_BCM=3Dm
CONFIG_BT_RTL=3Dm
CONFIG_BT_HCIBTUSB=3Dm
CONFIG_BT_HCIBTUSB_AUTOSUSPEND=3Dy
CONFIG_BT_HCIBTUSB_BCM=3Dy
# CONFIG_BT_HCIBTUSB_MTK is not set
CONFIG_BT_HCIBTUSB_RTL=3Dy
CONFIG_BT_HCIBTSDIO=3Dm
CONFIG_BT_HCIUART=3Dm
CONFIG_BT_HCIUART_H4=3Dy
CONFIG_BT_HCIUART_BCSP=3Dy
CONFIG_BT_HCIUART_ATH3K=3Dy
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
CONFIG_BT_HCIBCM203X=3Dm
CONFIG_BT_HCIBPA10X=3Dm
CONFIG_BT_HCIBFUSB=3Dm
CONFIG_BT_HCIVHCI=3Dm
CONFIG_BT_MRVL=3Dm
CONFIG_BT_MRVL_SDIO=3Dm
CONFIG_BT_ATH3K=3Dm
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=3Dy
CONFIG_FIB_RULES=3Dy
CONFIG_WIRELESS=3Dy
CONFIG_CFG80211=3Dm
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=3Dy
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=3Dy
CONFIG_CFG80211_DEFAULT_PS=3Dy
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=3Dy
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=3Dm
CONFIG_MAC80211_HAS_RC=3Dy
CONFIG_MAC80211_RC_MINSTREL=3Dy
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=3Dy
CONFIG_MAC80211_RC_DEFAULT=3D"minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=3Dy
CONFIG_MAC80211_DEBUGFS=3Dy
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=3D0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=3Dm
CONFIG_RFKILL_LEDS=3Dy
CONFIG_RFKILL_INPUT=3Dy
# CONFIG_RFKILL_GPIO is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=3Dm
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=3Dy
# CONFIG_NFC is not set
CONFIG_PSAMPLE=3Dm
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=3Dy
# CONFIG_LWTUNNEL_BPF is not set
CONFIG_DST_CACHE=3Dy
CONFIG_GRO_CELLS=3Dy
CONFIG_SOCK_VALIDATE_XMIT=3Dy
CONFIG_NET_SOCK_MSG=3Dy
CONFIG_NET_DEVLINK=3Dy
CONFIG_PAGE_POOL=3Dy
CONFIG_FAILOVER=3Dm
CONFIG_HAVE_EBPF_JIT=3Dy

#
# Device Drivers
#
CONFIG_HAVE_EISA=3Dy
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=3Dy
CONFIG_PCI=3Dy
CONFIG_PCI_DOMAINS=3Dy
CONFIG_PCIEPORTBUS=3Dy
CONFIG_HOTPLUG_PCI_PCIE=3Dy
CONFIG_PCIEAER=3Dy
CONFIG_PCIEAER_INJECT=3Dm
CONFIG_PCIE_ECRC=3Dy
CONFIG_PCIEASPM=3Dy
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=3Dy
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=3Dy
CONFIG_PCIE_DPC=3Dy
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
CONFIG_PCI_MSI=3Dy
CONFIG_PCI_MSI_IRQ_DOMAIN=3Dy
CONFIG_PCI_QUIRKS=3Dy
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=3Dy
# CONFIG_PCI_PF_STUB is not set
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=3Dy
CONFIG_PCI_LOCKLESS_CONFIG=3Dy
CONFIG_PCI_IOV=3Dy
CONFIG_PCI_PRI=3Dy
CONFIG_PCI_PASID=3Dy
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=3Dy
CONFIG_PCI_HYPERV=3Dm
CONFIG_HOTPLUG_PCI=3Dy
CONFIG_HOTPLUG_PCI_ACPI=3Dy
CONFIG_HOTPLUG_PCI_ACPI_IBM=3Dm
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=3Dy

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support

CONFIG_VMD=3Dy
CONFIG_PCI_HYPERV_INTERFACE=3Dm

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_PCCARD=3Dy
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=3Dy

#
# PC-card bridges
#
CONFIG_YENTA=3Dm
CONFIG_YENTA_O2=3Dy
CONFIG_YENTA_RICOH=3Dy
CONFIG_YENTA_TI=3Dy
CONFIG_YENTA_ENE_TUNE=3Dy
CONFIG_YENTA_TOSHIBA=3Dy
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=3Dy
CONFIG_DEVTMPFS_MOUNT=3Dy
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy

#
# Firmware loader
#
CONFIG_FW_LOADER=3Dy
CONFIG_FW_LOADER_PAGED_BUF=3Dy
CONFIG_EXTRA_FIRMWARE=3D""
CONFIG_FW_LOADER_USER_HELPER=3Dy
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=3Dy
CONFIG_ALLOW_DEV_COREDUMP=3Dy
CONFIG_DEV_COREDUMP=3Dy
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_HMEM_REPORTING=3Dy
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=3Dy
CONFIG_GENERIC_CPU_AUTOPROBE=3Dy
CONFIG_GENERIC_CPU_VULNERABILITIES=3Dy
CONFIG_REGMAP=3Dy
CONFIG_REGMAP_I2C=3Dy
CONFIG_REGMAP_SPI=3Dy
CONFIG_DMA_SHARED_BUFFER=3Dy
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# end of Bus devices

CONFIG_CONNECTOR=3Dy
CONFIG_PROC_EVENTS=3Dy
# CONFIG_GNSS is not set
CONFIG_MTD=3Dm
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=3Dm
CONFIG_MTD_BLOCK=3Dm
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy
CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy
CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy
CONFIG_MTD_CFI_I1=3Dy
CONFIG_MTD_CFI_I2=3Dy
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=3Dm
CONFIG_MTD_UBI_WL_THRESHOLD=3D4096
CONFIG_MTD_UBI_BEB_LIMIT=3D20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=3Dy
CONFIG_PARPORT=3Dm
CONFIG_PARPORT_PC=3Dm
CONFIG_PARPORT_SERIAL=3Dm
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=3Dy
CONFIG_PARPORT_NOT_PC=3Dy
CONFIG_PNP=3Dy
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=3Dy
CONFIG_BLK_DEV=3Dy
CONFIG_BLK_DEV_NULL_BLK=3Dm
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=3Dm
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=3Dm
CONFIG_ZRAM_WRITEBACK=3Dy
# CONFIG_ZRAM_MEMORY_TRACKING is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=3Dm
CONFIG_BLK_DEV_LOOP_MIN_COUNT=3D0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=3Dm
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=3Dm
CONFIG_BLK_DEV_RAM_COUNT=3D16
CONFIG_BLK_DEV_RAM_SIZE=3D16384
CONFIG_CDROM_PKTCDVD=3Dm
CONFIG_CDROM_PKTCDVD_BUFFERS=3D8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=3Dm
CONFIG_VIRTIO_BLK=3Dm
# CONFIG_VIRTIO_BLK_SCSI is not set
CONFIG_BLK_DEV_RBD=3Dm
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=3Dm
CONFIG_BLK_DEV_NVME=3Dm
CONFIG_NVME_MULTIPATH=3Dy
CONFIG_NVME_FABRICS=3Dm
CONFIG_NVME_RDMA=3Dm
CONFIG_NVME_FC=3Dm
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=3Dm
CONFIG_NVME_TARGET_LOOP=3Dm
CONFIG_NVME_TARGET_RDMA=3Dm
CONFIG_NVME_TARGET_FC=3Dm
CONFIG_NVME_TARGET_FCLOOP=3Dm
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=3Dm
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=3Dm
CONFIG_TIFM_7XX1=3Dm
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=3Dm
CONFIG_SGI_XP=3Dm
CONFIG_HP_ILO=3Dm
CONFIG_SGI_GRU=3Dm
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=3Dm
CONFIG_ISL29003=3Dm
CONFIG_ISL29020=3Dm
CONFIG_SENSORS_TSL2550=3Dm
CONFIG_SENSORS_BH1770=3Dm
CONFIG_SENSORS_APDS990X=3Dm
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=3Dm
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=3Dm
CONFIG_PVPANIC=3Dy
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=3Dm
CONFIG_EEPROM_MAX6875=3Dm
CONFIG_EEPROM_93CX6=3Dm
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=3Dm
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=3Dy

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=3Dm
CONFIG_ALTERA_STAPL=3Dm
CONFIG_INTEL_MEI=3Dm
CONFIG_INTEL_MEI_ME=3Dm
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=3Dm

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=3Dm
CONFIG_MISC_RTSX_USB=3Dm
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=3Dy
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=3Dy
CONFIG_RAID_ATTRS=3Dm
CONFIG_SCSI=3Dy
CONFIG_SCSI_DMA=3Dy
CONFIG_SCSI_NETLINK=3Dy
CONFIG_SCSI_PROC_FS=3Dy

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dm
CONFIG_CHR_DEV_ST=3Dm
CONFIG_BLK_DEV_SR=3Dm
CONFIG_BLK_DEV_SR_VENDOR=3Dy
CONFIG_CHR_DEV_SG=3Dm
CONFIG_CHR_DEV_SCH=3Dm
CONFIG_SCSI_ENCLOSURE=3Dm
CONFIG_SCSI_CONSTANTS=3Dy
CONFIG_SCSI_LOGGING=3Dy
CONFIG_SCSI_SCAN_ASYNC=3Dy

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=3Dm
CONFIG_SCSI_FC_ATTRS=3Dm
CONFIG_SCSI_ISCSI_ATTRS=3Dm
CONFIG_SCSI_SAS_ATTRS=3Dm
CONFIG_SCSI_SAS_LIBSAS=3Dm
CONFIG_SCSI_SAS_ATA=3Dy
CONFIG_SCSI_SAS_HOST_SMP=3Dy
CONFIG_SCSI_SRP_ATTRS=3Dm
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=3Dy
CONFIG_ISCSI_TCP=3Dm
CONFIG_ISCSI_BOOT_SYSFS=3Dm
# CONFIG_SCSI_CXGB3_ISCSI is not set
CONFIG_SCSI_CXGB4_ISCSI=3Dm
CONFIG_SCSI_BNX2_ISCSI=3Dm
CONFIG_SCSI_BNX2X_FCOE=3Dm
CONFIG_BE2ISCSI=3Dm
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=3Dm
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=3Dm
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=3Dm
CONFIG_SCSI_MPT3SAS=3Dm
CONFIG_SCSI_MPT2SAS_MAX_SGE=3D128
CONFIG_SCSI_MPT3SAS_MAX_SGE=3D128
CONFIG_SCSI_MPT2SAS=3Dm
CONFIG_SCSI_SMARTPQI=3Dm
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=3Dm
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=3Dm
CONFIG_LIBFC=3Dm
CONFIG_LIBFCOE=3Dm
# CONFIG_FCOE is not set
CONFIG_FCOE_FNIC=3Dm
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=3Dm
# CONFIG_TCM_QLA2XXX is not set
CONFIG_SCSI_QLA_ISCSI=3Dm
CONFIG_QEDI=3Dm
CONFIG_QEDF=3Dm
CONFIG_SCSI_LPFC=3Dm
# CONFIG_SCSI_LPFC_DEBUG_FS is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=3Dm
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=3Dm
CONFIG_SCSI_CHELSIO_FCOE=3Dm
CONFIG_SCSI_DH=3Dy
CONFIG_SCSI_DH_RDAC=3Dy
CONFIG_SCSI_DH_HP_SW=3Dy
CONFIG_SCSI_DH_EMC=3Dy
CONFIG_SCSI_DH_ALUA=3Dy
# end of SCSI device support

CONFIG_ATA=3Dm
CONFIG_ATA_VERBOSE_ERROR=3Dy
CONFIG_ATA_ACPI=3Dy
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=3Dy

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=3Dm
CONFIG_SATA_MOBILE_LPM_POLICY=3D0
CONFIG_SATA_AHCI_PLATFORM=3Dm
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=3Dy

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=3Dy

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=3Dm
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=3Dm
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=3Dy
CONFIG_BLK_DEV_MD=3Dy
CONFIG_MD_AUTODETECT=3Dy
CONFIG_MD_LINEAR=3Dm
CONFIG_MD_RAID0=3Dm
CONFIG_MD_RAID1=3Dm
CONFIG_MD_RAID10=3Dm
CONFIG_MD_RAID456=3Dm
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=3Dm
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=3Dy
CONFIG_BLK_DEV_DM=3Dm
CONFIG_DM_DEBUG=3Dy
CONFIG_DM_BUFIO=3Dm
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=3Dm
CONFIG_DM_PERSISTENT_DATA=3Dm
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=3Dm
CONFIG_DM_SNAPSHOT=3Dm
CONFIG_DM_THIN_PROVISIONING=3Dm
CONFIG_DM_CACHE=3Dm
CONFIG_DM_CACHE_SMQ=3Dm
CONFIG_DM_WRITECACHE=3Dm
CONFIG_DM_ERA=3Dm
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=3Dm
CONFIG_DM_LOG_USERSPACE=3Dm
CONFIG_DM_RAID=3Dm
CONFIG_DM_ZERO=3Dm
CONFIG_DM_MULTIPATH=3Dm
CONFIG_DM_MULTIPATH_QL=3Dm
CONFIG_DM_MULTIPATH_ST=3Dm
CONFIG_DM_DELAY=3Dm
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=3Dy
CONFIG_DM_FLAKEY=3Dm
CONFIG_DM_VERITY=3Dm
CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=3Dy
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=3Dm
CONFIG_DM_LOG_WRITES=3Dm
CONFIG_DM_INTEGRITY=3Dm
CONFIG_TARGET_CORE=3Dm
CONFIG_TCM_IBLOCK=3Dm
CONFIG_TCM_FILEIO=3Dm
CONFIG_TCM_PSCSI=3Dm
CONFIG_TCM_USER2=3Dm
CONFIG_LOOPBACK_TARGET=3Dm
CONFIG_TCM_FC=3Dm
CONFIG_ISCSI_TARGET=3Dm
CONFIG_ISCSI_TARGET_CXGB4=3Dm
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=3Dy
CONFIG_FUSION_SPI=3Dm
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=3Dm
CONFIG_FUSION_MAX_SGE=3D128
# CONFIG_FUSION_CTL is not set
CONFIG_FUSION_LOGGING=3Dy

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=3Dm
CONFIG_FIREWIRE_OHCI=3Dm
CONFIG_FIREWIRE_SBP2=3Dm
CONFIG_FIREWIRE_NET=3Dm
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=3Dy
CONFIG_MAC_EMUMOUSEBTN=3Dy
CONFIG_NETDEVICES=3Dy
CONFIG_MII=3Dm
CONFIG_NET_CORE=3Dy
CONFIG_BONDING=3Dm
CONFIG_DUMMY=3Dm
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=3Dy
CONFIG_IFB=3Dm
CONFIG_NET_TEAM=3Dm
CONFIG_NET_TEAM_MODE_BROADCAST=3Dm
CONFIG_NET_TEAM_MODE_ROUNDROBIN=3Dm
CONFIG_NET_TEAM_MODE_RANDOM=3Dm
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=3Dm
CONFIG_NET_TEAM_MODE_LOADBALANCE=3Dm
CONFIG_MACVLAN=3Dm
CONFIG_MACVTAP=3Dm
CONFIG_IPVLAN_L3S=3Dy
CONFIG_IPVLAN=3Dm
CONFIG_IPVTAP=3Dm
CONFIG_VXLAN=3Dm
CONFIG_GENEVE=3Dm
# CONFIG_GTP is not set
CONFIG_MACSEC=3Dm
CONFIG_NETCONSOLE=3Dm
CONFIG_NETCONSOLE_DYNAMIC=3Dy
CONFIG_NETPOLL=3Dy
CONFIG_NET_POLL_CONTROLLER=3Dy
CONFIG_TUN=3Dm
CONFIG_TAP=3Dm
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=3Dm
CONFIG_VIRTIO_NET=3Dm
CONFIG_NLMON=3Dm
CONFIG_NET_VRF=3Dm
CONFIG_VSOCKMON=3Dm
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=3Dy
CONFIG_MDIO=3Dm
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=3Dy
CONFIG_ENA_ETHERNET=3Dm
CONFIG_NET_VENDOR_AMD=3Dy
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
CONFIG_AMD_XGBE=3Dm
# CONFIG_AMD_XGBE_DCB is not set
CONFIG_AMD_XGBE_HAVE_ECC=3Dy
CONFIG_NET_VENDOR_AQUANTIA=3Dy
CONFIG_AQTION=3Dm
# CONFIG_NET_VENDOR_ARC is not set
CONFIG_NET_VENDOR_ATHEROS=3Dy
CONFIG_ATL2=3Dm
CONFIG_ATL1=3Dm
CONFIG_ATL1E=3Dm
CONFIG_ATL1C=3Dm
CONFIG_ALX=3Dm
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_VENDOR_BROADCOM=3Dy
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
CONFIG_BNX2=3Dm
CONFIG_CNIC=3Dm
CONFIG_TIGON3=3Dm
CONFIG_TIGON3_HWMON=3Dy
CONFIG_BNX2X=3Dm
CONFIG_BNX2X_SRIOV=3Dy
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=3Dm
CONFIG_BNXT_SRIOV=3Dy
CONFIG_BNXT_FLOWER_OFFLOAD=3Dy
CONFIG_BNXT_DCB=3Dy
# CONFIG_BNXT_HWMON is not set
CONFIG_NET_VENDOR_BROCADE=3Dy
# CONFIG_BNA is not set
# CONFIG_NET_VENDOR_CADENCE is not set
CONFIG_NET_VENDOR_CAVIUM=3Dy
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=3Dy
CONFIG_LIQUIDIO=3Dm
CONFIG_LIQUIDIO_VF=3Dm
CONFIG_NET_VENDOR_CHELSIO=3Dy
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
CONFIG_CHELSIO_T4=3Dm
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=3Dm
CONFIG_CHELSIO_LIB=3Dm
CONFIG_NET_VENDOR_CISCO=3Dy
CONFIG_ENIC=3Dm
# CONFIG_NET_VENDOR_CORTINA is not set
# CONFIG_CX_ECAT is not set
CONFIG_DNET=3Dm
CONFIG_NET_VENDOR_DEC=3Dy
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=3Dy
CONFIG_DL2K=3Dm
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=3Dy
CONFIG_BE2NET=3Dm
CONFIG_BE2NET_HWMON=3Dy
# CONFIG_BE2NET_BE2 is not set
# CONFIG_BE2NET_BE3 is not set
CONFIG_BE2NET_LANCER=3Dy
CONFIG_BE2NET_SKYHAWK=3Dy
# CONFIG_NET_VENDOR_EZCHIP is not set
CONFIG_NET_VENDOR_GOOGLE=3Dy
CONFIG_GVE=3Dm
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_HUAWEI=3Dy
CONFIG_HINIC=3Dm
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=3Dy
# CONFIG_E100 is not set
# CONFIG_E1000 is not set
CONFIG_E1000E=3Dm
CONFIG_E1000E_HWTS=3Dy
CONFIG_IGB=3Dm
CONFIG_IGB_HWMON=3Dy
CONFIG_IGB_DCA=3Dy
CONFIG_IGBVF=3Dm
# CONFIG_IXGB is not set
CONFIG_IXGBE=3Dm
CONFIG_IXGBE_HWMON=3Dy
CONFIG_IXGBE_DCA=3Dy
CONFIG_IXGBE_DCB=3Dy
CONFIG_IXGBE_IPSEC=3Dy
CONFIG_IXGBEVF=3Dm
CONFIG_IXGBEVF_IPSEC=3Dy
CONFIG_I40E=3Dm
CONFIG_I40E_DCB=3Dy
CONFIG_IAVF=3Dm
CONFIG_I40EVF=3Dm
CONFIG_ICE=3Dm
CONFIG_FM10K=3Dm
CONFIG_IGC=3Dm
# CONFIG_JME is not set
# CONFIG_NET_VENDOR_MARVELL is not set
CONFIG_NET_VENDOR_MELLANOX=3Dy
CONFIG_MLX4_EN=3Dm
CONFIG_MLX4_EN_DCB=3Dy
CONFIG_MLX4_CORE=3Dm
CONFIG_MLX4_DEBUG=3Dy
# CONFIG_MLX4_CORE_GEN2 is not set
CONFIG_MLX5_CORE=3Dm
CONFIG_MLX5_ACCEL=3Dy
CONFIG_MLX5_FPGA=3Dy
CONFIG_MLX5_CORE_EN=3Dy
CONFIG_MLX5_EN_ARFS=3Dy
CONFIG_MLX5_EN_RXNFC=3Dy
CONFIG_MLX5_MPFS=3Dy
CONFIG_MLX5_ESWITCH=3Dy
CONFIG_MLX5_CORE_EN_DCB=3Dy
CONFIG_MLX5_CORE_IPOIB=3Dy
# CONFIG_MLX5_FPGA_IPSEC is not set
# CONFIG_MLX5_FPGA_TLS is not set
# CONFIG_MLX5_TLS is not set
CONFIG_MLX5_SW_STEERING=3Dy
CONFIG_MLXSW_CORE=3Dm
CONFIG_MLXSW_CORE_HWMON=3Dy
CONFIG_MLXSW_CORE_THERMAL=3Dy
CONFIG_MLXSW_PCI=3Dm
CONFIG_MLXSW_I2C=3Dm
CONFIG_MLXSW_SWITCHIB=3Dm
CONFIG_MLXSW_SWITCHX2=3Dm
CONFIG_MLXSW_SPECTRUM=3Dm
CONFIG_MLXSW_SPECTRUM_DCB=3Dy
CONFIG_MLXSW_MINIMAL=3Dm
CONFIG_MLXFW=3Dm
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
# CONFIG_NET_VENDOR_MICROSEMI is not set
CONFIG_NET_VENDOR_MYRI=3Dy
CONFIG_MYRI10GE=3Dm
CONFIG_MYRI10GE_DCA=3Dy
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NETERION is not set
CONFIG_NET_VENDOR_NETRONOME=3Dy
CONFIG_NFP=3Dm
CONFIG_NFP_APP_FLOWER=3Dy
CONFIG_NFP_APP_ABM_NIC=3Dy
# CONFIG_NFP_DEBUG is not set
# CONFIG_NET_VENDOR_NI is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=3Dy
CONFIG_ETHOC=3Dm
# CONFIG_NET_VENDOR_PACKET_ENGINES is not set
CONFIG_NET_VENDOR_PENSANDO=3Dy
CONFIG_IONIC=3Dm
CONFIG_NET_VENDOR_QLOGIC=3Dy
CONFIG_QLA3XXX=3Dm
# CONFIG_QLCNIC is not set
CONFIG_NETXEN_NIC=3Dm
CONFIG_QED=3Dm
CONFIG_QED_LL2=3Dy
CONFIG_QED_SRIOV=3Dy
CONFIG_QEDE=3Dm
CONFIG_QED_RDMA=3Dy
CONFIG_QED_ISCSI=3Dy
CONFIG_QED_FCOE=3Dy
CONFIG_QED_OOO=3Dy
# CONFIG_NET_VENDOR_QUALCOMM is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=3Dy
# CONFIG_ATP is not set
CONFIG_8139CP=3Dm
CONFIG_8139TOO=3Dm
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=3Dy
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=3Dm
# CONFIG_NET_VENDOR_RENESAS is not set
CONFIG_NET_VENDOR_ROCKER=3Dy
CONFIG_ROCKER=3Dm
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=3Dy
CONFIG_SFC=3Dm
CONFIG_SFC_MTD=3Dy
CONFIG_SFC_MCDI_MON=3Dy
CONFIG_SFC_SRIOV=3Dy
CONFIG_SFC_MCDI_LOGGING=3Dy
# CONFIG_SFC_FALCON is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_SOCIONEXT is not set
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_NET_VENDOR_XILINX is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=3Dy
CONFIG_MDIO_BUS=3Dy
CONFIG_MDIO_BCM_UNIMAC=3Dm
CONFIG_MDIO_BITBANG=3Dm
CONFIG_MDIO_CAVIUM=3Dm
# CONFIG_MDIO_GPIO is not set
CONFIG_MDIO_MSCC_MIIM=3Dm
CONFIG_MDIO_THUNDER=3Dm
CONFIG_PHYLIB=3Dy
CONFIG_SWPHY=3Dy
CONFIG_LED_TRIGGER_PHY=3Dy

#
# MII PHY device drivers
#
# CONFIG_ADIN_PHY is not set
CONFIG_AMD_PHY=3Dm
CONFIG_AQUANTIA_PHY=3Dm
CONFIG_AX88796B_PHY=3Dm
CONFIG_AT803X_PHY=3Dm
CONFIG_BCM7XXX_PHY=3Dm
CONFIG_BCM87XX_PHY=3Dm
CONFIG_BCM_NET_PHYLIB=3Dm
CONFIG_BROADCOM_PHY=3Dm
CONFIG_CICADA_PHY=3Dm
CONFIG_CORTINA_PHY=3Dm
CONFIG_DAVICOM_PHY=3Dm
CONFIG_DP83822_PHY=3Dm
CONFIG_DP83TC811_PHY=3Dm
CONFIG_DP83848_PHY=3Dm
CONFIG_DP83867_PHY=3Dm
CONFIG_FIXED_PHY=3Dy
CONFIG_ICPLUS_PHY=3Dm
CONFIG_INTEL_XWAY_PHY=3Dm
CONFIG_LSI_ET1011C_PHY=3Dm
CONFIG_LXT_PHY=3Dm
CONFIG_MARVELL_PHY=3Dm
CONFIG_MARVELL_10G_PHY=3Dm
CONFIG_MICREL_PHY=3Dm
CONFIG_MICROCHIP_PHY=3Dm
CONFIG_MICROCHIP_T1_PHY=3Dm
CONFIG_MICROSEMI_PHY=3Dm
CONFIG_NATIONAL_PHY=3Dm
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_QSEMI_PHY=3Dm
CONFIG_REALTEK_PHY=3Dm
CONFIG_RENESAS_PHY=3Dm
CONFIG_ROCKCHIP_PHY=3Dm
CONFIG_SMSC_PHY=3Dm
CONFIG_STE10XP=3Dm
CONFIG_TERANETICS_PHY=3Dm
CONFIG_VITESSE_PHY=3Dm
CONFIG_XILINX_GMII2RGMII=3Dm
CONFIG_MICREL_KS8995MA=3Dm
# CONFIG_PLIP is not set
CONFIG_PPP=3Dm
CONFIG_PPP_BSDCOMP=3Dm
CONFIG_PPP_DEFLATE=3Dm
CONFIG_PPP_FILTER=3Dy
CONFIG_PPP_MPPE=3Dm
CONFIG_PPP_MULTILINK=3Dy
CONFIG_PPPOATM=3Dm
CONFIG_PPPOE=3Dm
CONFIG_PPTP=3Dm
CONFIG_PPPOL2TP=3Dm
CONFIG_PPP_ASYNC=3Dm
CONFIG_PPP_SYNC_TTY=3Dm
CONFIG_SLIP=3Dm
CONFIG_SLHC=3Dm
CONFIG_SLIP_COMPRESSED=3Dy
CONFIG_SLIP_SMART=3Dy
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=3Dy
CONFIG_USB_CATC=3Dm
CONFIG_USB_KAWETH=3Dm
CONFIG_USB_PEGASUS=3Dm
CONFIG_USB_RTL8150=3Dm
CONFIG_USB_RTL8152=3Dm
CONFIG_USB_LAN78XX=3Dm
CONFIG_USB_USBNET=3Dm
CONFIG_USB_NET_AX8817X=3Dm
CONFIG_USB_NET_AX88179_178A=3Dm
CONFIG_USB_NET_CDCETHER=3Dm
CONFIG_USB_NET_CDC_EEM=3Dm
CONFIG_USB_NET_CDC_NCM=3Dm
CONFIG_USB_NET_HUAWEI_CDC_NCM=3Dm
CONFIG_USB_NET_CDC_MBIM=3Dm
CONFIG_USB_NET_DM9601=3Dm
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=3Dm
CONFIG_USB_NET_SMSC95XX=3Dm
CONFIG_USB_NET_GL620A=3Dm
CONFIG_USB_NET_NET1080=3Dm
CONFIG_USB_NET_PLUSB=3Dm
CONFIG_USB_NET_MCS7830=3Dm
CONFIG_USB_NET_RNDIS_HOST=3Dm
CONFIG_USB_NET_CDC_SUBSET_ENABLE=3Dm
CONFIG_USB_NET_CDC_SUBSET=3Dm
CONFIG_USB_ALI_M5632=3Dy
CONFIG_USB_AN2720=3Dy
CONFIG_USB_BELKIN=3Dy
CONFIG_USB_ARMLINUX=3Dy
CONFIG_USB_EPSON2888=3Dy
CONFIG_USB_KC2190=3Dy
CONFIG_USB_NET_ZAURUS=3Dm
CONFIG_USB_NET_CX82310_ETH=3Dm
CONFIG_USB_NET_KALMIA=3Dm
CONFIG_USB_NET_QMI_WWAN=3Dm
CONFIG_USB_HSO=3Dm
CONFIG_USB_NET_INT51X1=3Dm
CONFIG_USB_IPHETH=3Dm
CONFIG_USB_SIERRA_NET=3Dm
CONFIG_USB_VL600=3Dm
CONFIG_USB_NET_CH9200=3Dm
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=3Dy
# CONFIG_WLAN_VENDOR_ADMTEK is not set
CONFIG_ATH_COMMON=3Dm
CONFIG_WLAN_VENDOR_ATH=3Dy
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_ATH9K_HW=3Dm
CONFIG_ATH9K_COMMON=3Dm
CONFIG_ATH9K_COMMON_DEBUG=3Dy
CONFIG_ATH9K_BTCOEX_SUPPORT=3Dy
CONFIG_ATH9K=3Dm
CONFIG_ATH9K_PCI=3Dy
CONFIG_ATH9K_AHB=3Dy
CONFIG_ATH9K_DEBUGFS=3Dy
# CONFIG_ATH9K_STATION_STATISTICS is not set
# CONFIG_ATH9K_DYNACK is not set
CONFIG_ATH9K_WOW=3Dy
CONFIG_ATH9K_RFKILL=3Dy
# CONFIG_ATH9K_CHANNEL_CONTEXT is not set
CONFIG_ATH9K_PCOEM=3Dy
# CONFIG_ATH9K_PCI_NO_EEPROM is not set
CONFIG_ATH9K_HTC=3Dm
# CONFIG_ATH9K_HTC_DEBUGFS is not set
# CONFIG_ATH9K_HWRNG is not set
# CONFIG_ATH9K_COMMON_SPECTRAL is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
CONFIG_ATH10K=3Dm
CONFIG_ATH10K_CE=3Dy
CONFIG_ATH10K_PCI=3Dm
# CONFIG_ATH10K_SDIO is not set
# CONFIG_ATH10K_USB is not set
# CONFIG_ATH10K_DEBUG is not set
CONFIG_ATH10K_DEBUGFS=3Dy
# CONFIG_ATH10K_SPECTRAL is not set
# CONFIG_ATH10K_TRACING is not set
# CONFIG_WCN36XX is not set
# CONFIG_WLAN_VENDOR_ATMEL is not set
CONFIG_WLAN_VENDOR_BROADCOM=3Dy
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
CONFIG_BRCMUTIL=3Dm
CONFIG_BRCMSMAC=3Dm
CONFIG_BRCMFMAC=3Dm
CONFIG_BRCMFMAC_PROTO_BCDC=3Dy
CONFIG_BRCMFMAC_PROTO_MSGBUF=3Dy
CONFIG_BRCMFMAC_SDIO=3Dy
CONFIG_BRCMFMAC_USB=3Dy
CONFIG_BRCMFMAC_PCIE=3Dy
# CONFIG_BRCM_TRACING is not set
# CONFIG_BRCMDBG is not set
# CONFIG_WLAN_VENDOR_CISCO is not set
CONFIG_WLAN_VENDOR_INTEL=3Dy
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
CONFIG_IWLWIFI=3Dm
CONFIG_IWLWIFI_LEDS=3Dy
CONFIG_IWLDVM=3Dm
CONFIG_IWLMVM=3Dm
CONFIG_IWLWIFI_OPMODE_MODULAR=3Dy
# CONFIG_IWLWIFI_BCAST_FILTERING is not set

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
CONFIG_IWLWIFI_DEBUGFS=3Dy
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
# end of Debugging Options

# CONFIG_WLAN_VENDOR_INTERSIL is not set
CONFIG_WLAN_VENDOR_MARVELL=3Dy
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
CONFIG_MWIFIEX=3Dm
CONFIG_MWIFIEX_SDIO=3Dm
CONFIG_MWIFIEX_PCIE=3Dm
CONFIG_MWIFIEX_USB=3Dm
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=3Dy
CONFIG_MT7601U=3Dm
CONFIG_MT76_CORE=3Dm
CONFIG_MT76_LEDS=3Dy
CONFIG_MT76_USB=3Dm
CONFIG_MT76x02_LIB=3Dm
CONFIG_MT76x02_USB=3Dm
CONFIG_MT76x0_COMMON=3Dm
CONFIG_MT76x0U=3Dm
CONFIG_MT76x0E=3Dm
CONFIG_MT76x2_COMMON=3Dm
CONFIG_MT76x2E=3Dm
CONFIG_MT76x2U=3Dm
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
CONFIG_WLAN_VENDOR_RALINK=3Dy
CONFIG_RT2X00=3Dm
# CONFIG_RT2400PCI is not set
# CONFIG_RT2500PCI is not set
# CONFIG_RT61PCI is not set
CONFIG_RT2800PCI=3Dm
CONFIG_RT2800PCI_RT33XX=3Dy
CONFIG_RT2800PCI_RT35XX=3Dy
CONFIG_RT2800PCI_RT53XX=3Dy
CONFIG_RT2800PCI_RT3290=3Dy
# CONFIG_RT2500USB is not set
# CONFIG_RT73USB is not set
CONFIG_RT2800USB=3Dm
CONFIG_RT2800USB_RT33XX=3Dy
CONFIG_RT2800USB_RT35XX=3Dy
CONFIG_RT2800USB_RT3573=3Dy
CONFIG_RT2800USB_RT53XX=3Dy
CONFIG_RT2800USB_RT55XX=3Dy
CONFIG_RT2800USB_UNKNOWN=3Dy
CONFIG_RT2800_LIB=3Dm
CONFIG_RT2800_LIB_MMIO=3Dm
CONFIG_RT2X00_LIB_MMIO=3Dm
CONFIG_RT2X00_LIB_PCI=3Dm
CONFIG_RT2X00_LIB_USB=3Dm
CONFIG_RT2X00_LIB=3Dm
CONFIG_RT2X00_LIB_FIRMWARE=3Dy
CONFIG_RT2X00_LIB_CRYPTO=3Dy
CONFIG_RT2X00_LIB_LEDS=3Dy
CONFIG_RT2X00_LIB_DEBUGFS=3Dy
# CONFIG_RT2X00_DEBUG is not set
CONFIG_WLAN_VENDOR_REALTEK=3Dy
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=3Dm
CONFIG_RTL8192CE=3Dm
CONFIG_RTL8192SE=3Dm
CONFIG_RTL8192DE=3Dm
CONFIG_RTL8723AE=3Dm
CONFIG_RTL8723BE=3Dm
CONFIG_RTL8188EE=3Dm
CONFIG_RTL8192EE=3Dm
CONFIG_RTL8821AE=3Dm
CONFIG_RTL8192CU=3Dm
CONFIG_RTLWIFI=3Dm
CONFIG_RTLWIFI_PCI=3Dm
CONFIG_RTLWIFI_USB=3Dm
# CONFIG_RTLWIFI_DEBUG is not set
CONFIG_RTL8192C_COMMON=3Dm
CONFIG_RTL8723_COMMON=3Dm
CONFIG_RTLBTCOEXIST=3Dm
CONFIG_RTL8XXXU=3Dm
# CONFIG_RTL8XXXU_UNTESTED is not set
CONFIG_RTW88=3Dm
CONFIG_RTW88_CORE=3Dm
CONFIG_RTW88_PCI=3Dm
CONFIG_RTW88_8822BE=3Dy
CONFIG_RTW88_8822CE=3Dy
# CONFIG_RTW88_DEBUG is not set
# CONFIG_RTW88_DEBUGFS is not set
# CONFIG_WLAN_VENDOR_RSI is not set
# CONFIG_WLAN_VENDOR_ST is not set
# CONFIG_WLAN_VENDOR_TI is not set
# CONFIG_WLAN_VENDOR_ZYDAS is not set
CONFIG_WLAN_VENDOR_QUANTENNA=3Dy
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=3Dm
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=3Dy
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=3Dm
CONFIG_HDLC_RAW=3Dm
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=3Dm
CONFIG_HDLC_FR=3Dm
CONFIG_HDLC_PPP=3Dm

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
CONFIG_DLCI=3Dm
CONFIG_DLCI_MAX=3D8
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=3Dm
CONFIG_IEEE802154_FAKELB=3Dm
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=3Dm
CONFIG_VMXNET3=3Dm
CONFIG_FUJITSU_ES=3Dm
CONFIG_THUNDERBOLT_NET=3Dm
CONFIG_HYPERV_NET=3Dm
CONFIG_NETDEVSIM=3Dm
CONFIG_NET_FAILOVER=3Dm
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=3Dy
CONFIG_INPUT_LEDS=3Dy
CONFIG_INPUT_FF_MEMLESS=3Dm
CONFIG_INPUT_POLLDEV=3Dm
CONFIG_INPUT_SPARSEKMAP=3Dm
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
CONFIG_INPUT_JOYDEV=3Dm
CONFIG_INPUT_EVDEV=3Dy
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=3Dy
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
CONFIG_MOUSE_PS2_ALPS=3Dy
CONFIG_MOUSE_PS2_BYD=3Dy
CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy
CONFIG_MOUSE_PS2_SYNAPTICS=3Dy
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=3Dy
CONFIG_MOUSE_PS2_CYPRESS=3Dy
CONFIG_MOUSE_PS2_LIFEBOOK=3Dy
CONFIG_MOUSE_PS2_TRACKPOINT=3Dy
CONFIG_MOUSE_PS2_ELANTECH=3Dy
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=3Dy
CONFIG_MOUSE_PS2_SENTELIC=3Dy
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=3Dy
CONFIG_MOUSE_PS2_VMMOUSE=3Dy
CONFIG_MOUSE_PS2_SMBUS=3Dy
CONFIG_MOUSE_SERIAL=3Dm
CONFIG_MOUSE_APPLETOUCH=3Dm
CONFIG_MOUSE_BCM5974=3Dm
CONFIG_MOUSE_CYAPA=3Dm
CONFIG_MOUSE_ELAN_I2C=3Dm
CONFIG_MOUSE_ELAN_I2C_I2C=3Dy
CONFIG_MOUSE_ELAN_I2C_SMBUS=3Dy
CONFIG_MOUSE_VSXXXAA=3Dm
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=3Dm
CONFIG_MOUSE_SYNAPTICS_USB=3Dm
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=3Dy
CONFIG_TABLET_USB_ACECAD=3Dm
CONFIG_TABLET_USB_AIPTEK=3Dm
CONFIG_TABLET_USB_GTCO=3Dm
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=3Dm
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=3Dm
CONFIG_INPUT_TOUCHSCREEN=3Dy
CONFIG_TOUCHSCREEN_PROPERTIES=3Dy
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=3Dm
CONFIG_TOUCHSCREEN_WACOM_W8001=3Dm
CONFIG_TOUCHSCREEN_WACOM_I2C=3Dm
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
CONFIG_INPUT_MISC=3Dy
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MSM_VIBRATOR is not set
CONFIG_INPUT_PCSPKR=3Dm
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=3Dm
CONFIG_INPUT_GP2A=3Dm
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_ATLAS_BTNS=3Dm
CONFIG_INPUT_ATI_REMOTE2=3Dm
CONFIG_INPUT_KEYSPAN_REMOTE=3Dm
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=3Dm
CONFIG_INPUT_YEALINK=3Dm
CONFIG_INPUT_CM109=3Dm
CONFIG_INPUT_UINPUT=3Dm
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=3Dm
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=3Dm
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=3Dm
CONFIG_RMI4_I2C=3Dm
CONFIG_RMI4_SPI=3Dm
CONFIG_RMI4_SMB=3Dm
CONFIG_RMI4_F03=3Dy
CONFIG_RMI4_F03_SERIO=3Dm
CONFIG_RMI4_2D_SENSOR=3Dy
CONFIG_RMI4_F11=3Dy
CONFIG_RMI4_F12=3Dy
CONFIG_RMI4_F30=3Dy
CONFIG_RMI4_F34=3Dy
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=3Dy

#
# Hardware I/O ports
#
CONFIG_SERIO=3Dy
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_SERIO_SERPORT=3Dy
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=3Dy
CONFIG_SERIO_RAW=3Dm
CONFIG_SERIO_ALTERA_PS2=3Dm
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=3Dm
CONFIG_HYPERV_KEYBOARD=3Dm
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=3Dy
CONFIG_VT=3Dy
CONFIG_CONSOLE_TRANSLATIONS=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_VT_CONSOLE_SLEEP=3Dy
CONFIG_HW_CONSOLE=3Dy
CONFIG_VT_HW_CONSOLE_BINDING=3Dy
CONFIG_UNIX98_PTYS=3Dy
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=3Dy
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=3Dm
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK=3Dm
CONFIG_SYNCLINKMP=3Dm
CONFIG_SYNCLINK_GT=3Dm
CONFIG_NOZOMI=3Dm
# CONFIG_ISI is not set
CONFIG_N_HDLC=3Dm
CONFIG_N_GSM=3Dm
# CONFIG_TRACE_SINK is not set
# CONFIG_NULL_TTY is not set
CONFIG_LDISC_AUTOLOAD=3Dy
CONFIG_DEVMEM=3Dy
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=3Dy
CONFIG_SERIAL_8250=3Dy
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=3Dy
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=3Dy
CONFIG_SERIAL_8250_DMA=3Dy
CONFIG_SERIAL_8250_PCI=3Dy
CONFIG_SERIAL_8250_EXAR=3Dy
CONFIG_SERIAL_8250_NR_UARTS=3D32
CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
CONFIG_SERIAL_8250_EXTENDED=3Dy
CONFIG_SERIAL_8250_MANY_PORTS=3Dy
CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=3Dy
CONFIG_SERIAL_8250_DWLIB=3Dy
CONFIG_SERIAL_8250_DW=3Dy
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=3Dy
CONFIG_SERIAL_8250_MID=3Dy

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_KGDB_NMI is not set
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
CONFIG_CONSOLE_POLL=3Dy
CONFIG_SERIAL_JSM=3Dm
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=3Dm
CONFIG_SERIAL_ARC_NR_PORTS=3D1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=3Dy
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=3Dm
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=3Dm
CONFIG_HVC_DRIVER=3Dy
CONFIG_HVC_IRQ=3Dy
CONFIG_HVC_XEN=3Dy
CONFIG_HVC_XEN_FRONTEND=3Dy
CONFIG_VIRTIO_CONSOLE=3Dm
CONFIG_IPMI_HANDLER=3Dm
CONFIG_IPMI_DMI_DECODE=3Dy
CONFIG_IPMI_PLAT_DATA=3Dy
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=3Dm
CONFIG_IPMI_SI=3Dm
CONFIG_IPMI_SSIF=3Dm
CONFIG_IPMI_WATCHDOG=3Dm
CONFIG_IPMI_POWEROFF=3Dm
CONFIG_HW_RANDOM=3Dy
CONFIG_HW_RANDOM_TIMERIOMEM=3Dm
CONFIG_HW_RANDOM_INTEL=3Dm
CONFIG_HW_RANDOM_AMD=3Dm
CONFIG_HW_RANDOM_VIA=3Dm
CONFIG_HW_RANDOM_VIRTIO=3Dy
CONFIG_NVRAM=3Dy
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=3Dy
CONFIG_MAX_RAW_DEVS=3D8192
CONFIG_HPET=3Dy
CONFIG_HPET_MMAP=3Dy
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=3Dm
CONFIG_UV_MMTIMER=3Dm
CONFIG_TCG_TPM=3Dy
CONFIG_HW_RANDOM_TPM=3Dy
CONFIG_TCG_TIS_CORE=3Dy
CONFIG_TCG_TIS=3Dy
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=3Dm
CONFIG_TCG_TIS_I2C_INFINEON=3Dm
CONFIG_TCG_TIS_I2C_NUVOTON=3Dm
CONFIG_TCG_NSC=3Dm
CONFIG_TCG_ATMEL=3Dm
CONFIG_TCG_INFINEON=3Dm
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=3Dy
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=3Dm
CONFIG_TCG_TIS_ST33ZP24_I2C=3Dm
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=3Dm
CONFIG_DEVPORT=3Dy
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=3Dy
CONFIG_ACPI_I2C_OPREGION=3Dy
CONFIG_I2C_BOARDINFO=3Dy
CONFIG_I2C_COMPAT=3Dy
CONFIG_I2C_CHARDEV=3Dm
CONFIG_I2C_MUX=3Dm

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=3Dm
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=3Dy
CONFIG_I2C_SMBUS=3Dm
CONFIG_I2C_ALGOBIT=3Dm
CONFIG_I2C_ALGOPCA=3Dm

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=3Dm
CONFIG_I2C_AMD756_S4882=3Dm
CONFIG_I2C_AMD8111=3Dm
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=3Dm
CONFIG_I2C_ISCH=3Dm
CONFIG_I2C_ISMT=3Dm
CONFIG_I2C_PIIX4=3Dm
CONFIG_I2C_NFORCE2=3Dm
CONFIG_I2C_NFORCE2_S4985=3Dm
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=3Dm
CONFIG_I2C_VIA=3Dm
CONFIG_I2C_VIAPRO=3Dm

#
# ACPI drivers
#
CONFIG_I2C_SCMI=3Dm

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=3Dm
CONFIG_I2C_DESIGNWARE_PLATFORM=3Dm
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=3Dy
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=3Dm
CONFIG_I2C_SIMTEC=3Dm
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=3Dm
CONFIG_I2C_PARPORT=3Dm
CONFIG_I2C_PARPORT_LIGHT=3Dm
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=3Dm
CONFIG_I2C_VIPERBOARD=3Dm

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=3Dm
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=3Dm
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=3Dy
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=3Dy
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=3Dy
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=3Dm
CONFIG_PPS_CLIENT_PARPORT=3Dm
CONFIG_PPS_CLIENT_GPIO=3Dm

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=3Dy
CONFIG_DP83640_PHY=3Dm
CONFIG_PTP_1588_CLOCK_KVM=3Dm
# end of PTP clock support

CONFIG_PINCTRL=3Dy
CONFIG_PINMUX=3Dy
CONFIG_PINCONF=3Dy
CONFIG_GENERIC_PINCONF=3Dy
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=3Dm
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=3Dy
# CONFIG_PINCTRL_CHERRYVIEW is not set
CONFIG_PINCTRL_INTEL=3Dm
CONFIG_PINCTRL_BROXTON=3Dm
CONFIG_PINCTRL_CANNONLAKE=3Dm
CONFIG_PINCTRL_CEDARFORK=3Dm
CONFIG_PINCTRL_DENVERTON=3Dm
CONFIG_PINCTRL_GEMINILAKE=3Dm
CONFIG_PINCTRL_ICELAKE=3Dm
CONFIG_PINCTRL_LEWISBURG=3Dm
CONFIG_PINCTRL_SUNRISEPOINT=3Dm
CONFIG_GPIOLIB=3Dy
CONFIG_GPIOLIB_FASTPATH_LIMIT=3D512
CONFIG_GPIO_ACPI=3Dy
CONFIG_GPIOLIB_IRQCHIP=3Dy
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=3Dy
CONFIG_GPIO_GENERIC=3Dm

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=3Dm
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=3Dm
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=3Dm
# end of USB GPIO expanders

# CONFIG_GPIO_MOCKUP is not set
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=3Dy
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=3Dy
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=3Dy
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=3Dm
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=3Dy
CONFIG_HWMON_VID=3Dm
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=3Dm
CONFIG_SENSORS_ABITUGURU3=3Dm
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=3Dm
CONFIG_SENSORS_AD7418=3Dm
CONFIG_SENSORS_ADM1021=3Dm
CONFIG_SENSORS_ADM1025=3Dm
CONFIG_SENSORS_ADM1026=3Dm
CONFIG_SENSORS_ADM1029=3Dm
CONFIG_SENSORS_ADM1031=3Dm
CONFIG_SENSORS_ADM9240=3Dm
CONFIG_SENSORS_ADT7X10=3Dm
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=3Dm
CONFIG_SENSORS_ADT7411=3Dm
CONFIG_SENSORS_ADT7462=3Dm
CONFIG_SENSORS_ADT7470=3Dm
CONFIG_SENSORS_ADT7475=3Dm
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=3Dm
CONFIG_SENSORS_K8TEMP=3Dm
CONFIG_SENSORS_K10TEMP=3Dm
CONFIG_SENSORS_FAM15H_POWER=3Dm
CONFIG_SENSORS_APPLESMC=3Dm
CONFIG_SENSORS_ASB100=3Dm
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=3Dm
CONFIG_SENSORS_DS620=3Dm
CONFIG_SENSORS_DS1621=3Dm
CONFIG_SENSORS_DELL_SMM=3Dm
CONFIG_SENSORS_I5K_AMB=3Dm
CONFIG_SENSORS_F71805F=3Dm
CONFIG_SENSORS_F71882FG=3Dm
CONFIG_SENSORS_F75375S=3Dm
CONFIG_SENSORS_FSCHMD=3Dm
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=3Dm
CONFIG_SENSORS_GL520SM=3Dm
CONFIG_SENSORS_G760A=3Dm
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=3Dm
CONFIG_SENSORS_IBMPEX=3Dm
# CONFIG_SENSORS_IIO_HWMON is not set
CONFIG_SENSORS_I5500=3Dm
CONFIG_SENSORS_CORETEMP=3Dm
CONFIG_SENSORS_IT87=3Dm
CONFIG_SENSORS_JC42=3Dm
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=3Dm
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=3Dm
CONFIG_SENSORS_LTC4215=3Dm
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=3Dm
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=3Dm
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=3Dm
CONFIG_SENSORS_MAX1619=3Dm
CONFIG_SENSORS_MAX1668=3Dm
CONFIG_SENSORS_MAX197=3Dm
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=3Dm
CONFIG_SENSORS_MAX6642=3Dm
CONFIG_SENSORS_MAX6650=3Dm
CONFIG_SENSORS_MAX6697=3Dm
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=3Dm
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=3Dm
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=3Dm
CONFIG_SENSORS_LM75=3Dm
CONFIG_SENSORS_LM77=3Dm
CONFIG_SENSORS_LM78=3Dm
CONFIG_SENSORS_LM80=3Dm
CONFIG_SENSORS_LM83=3Dm
CONFIG_SENSORS_LM85=3Dm
CONFIG_SENSORS_LM87=3Dm
CONFIG_SENSORS_LM90=3Dm
CONFIG_SENSORS_LM92=3Dm
CONFIG_SENSORS_LM93=3Dm
CONFIG_SENSORS_LM95234=3Dm
CONFIG_SENSORS_LM95241=3Dm
CONFIG_SENSORS_LM95245=3Dm
CONFIG_SENSORS_PC87360=3Dm
CONFIG_SENSORS_PC87427=3Dm
CONFIG_SENSORS_NTC_THERMISTOR=3Dm
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=3Dm
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=3Dm
CONFIG_PMBUS=3Dm
CONFIG_SENSORS_PMBUS=3Dm
CONFIG_SENSORS_ADM1275=3Dm
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=3Dm
CONFIG_SENSORS_LTC2978=3Dm
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=3Dm
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=3Dm
CONFIG_SENSORS_MAX8688=3Dm
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=3Dm
CONFIG_SENSORS_UCD9200=3Dm
CONFIG_SENSORS_ZL6100=3Dm
CONFIG_SENSORS_SHT15=3Dm
CONFIG_SENSORS_SHT21=3Dm
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=3Dm
CONFIG_SENSORS_DME1737=3Dm
CONFIG_SENSORS_EMC1403=3Dm
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=3Dm
CONFIG_SENSORS_SMSC47M1=3Dm
CONFIG_SENSORS_SMSC47M192=3Dm
CONFIG_SENSORS_SMSC47B397=3Dm
CONFIG_SENSORS_SCH56XX_COMMON=3Dm
CONFIG_SENSORS_SCH5627=3Dm
CONFIG_SENSORS_SCH5636=3Dm
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=3Dm
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=3Dm
CONFIG_SENSORS_INA209=3Dm
CONFIG_SENSORS_INA2XX=3Dm
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=3Dm
CONFIG_SENSORS_TMP102=3Dm
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=3Dm
CONFIG_SENSORS_TMP421=3Dm
CONFIG_SENSORS_VIA_CPUTEMP=3Dm
CONFIG_SENSORS_VIA686A=3Dm
CONFIG_SENSORS_VT1211=3Dm
CONFIG_SENSORS_VT8231=3Dm
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=3Dm
CONFIG_SENSORS_W83791D=3Dm
CONFIG_SENSORS_W83792D=3Dm
CONFIG_SENSORS_W83793=3Dm
CONFIG_SENSORS_W83795=3Dm
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=3Dm
CONFIG_SENSORS_W83L786NG=3Dm
CONFIG_SENSORS_W83627HF=3Dm
CONFIG_SENSORS_W83627EHF=3Dm
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=3Dm
CONFIG_SENSORS_ATK0110=3Dm
CONFIG_THERMAL=3Dy
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=3D0
CONFIG_THERMAL_HWMON=3Dy
CONFIG_THERMAL_WRITABLE_TRIPS=3Dy
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=3Dy
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=3Dy
CONFIG_THERMAL_GOV_STEP_WISE=3Dy
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=3Dy
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=3Dm
CONFIG_X86_PKG_TEMP_THERMAL=3Dm
CONFIG_INTEL_SOC_DTS_IOSF_CORE=3Dm
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=3Dm
CONFIG_ACPI_THERMAL_REL=3Dm
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=3Dy
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=3Dy
CONFIG_WATCHDOG_CORE=3Dy
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=3Dy
CONFIG_WATCHDOG_OPEN_TIMEOUT=3D0
CONFIG_WATCHDOG_SYSFS=3Dy

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=3Dm
CONFIG_WDAT_WDT=3Dm
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=3Dm
CONFIG_ALIM7101_WDT=3Dm
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=3Dm
CONFIG_SP5100_TCO=3Dm
CONFIG_SBC_FITPC2_WATCHDOG=3Dm
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=3Dm
CONFIG_IBMASR=3Dm
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=3Dm
CONFIG_IE6XX_WDT=3Dm
CONFIG_ITCO_WDT=3Dm
CONFIG_ITCO_VENDOR_SUPPORT=3Dy
CONFIG_IT8712F_WDT=3Dm
CONFIG_IT87_WDT=3Dm
CONFIG_HP_WATCHDOG=3Dm
CONFIG_HPWDT_NMI_DECODING=3Dy
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=3Dm
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=3Dm
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=3Dm
CONFIG_W83627HF_WDT=3Dm
CONFIG_W83877F_WDT=3Dm
CONFIG_W83977F_WDT=3Dm
CONFIG_MACHZ_WDT=3Dm
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=3Dm
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=3Dm

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=3Dm
CONFIG_WDTPCI=3Dm

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=3Dm
CONFIG_SSB_POSSIBLE=3Dy
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=3Dy
CONFIG_BCMA=3Dm
CONFIG_BCMA_HOST_PCI_POSSIBLE=3Dy
CONFIG_BCMA_HOST_PCI=3Dy
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=3Dy
CONFIG_BCMA_DRIVER_GMAC_CMN=3Dy
CONFIG_BCMA_DRIVER_GPIO=3Dy
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=3Dy
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=3Dm
CONFIG_LPC_SCH=3Dm
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=3Dy
CONFIG_MFD_INTEL_LPSS_ACPI=3Dy
CONFIG_MFD_INTEL_LPSS_PCI=3Dy
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=3Dm
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=3Dm
CONFIG_MFD_SM501_GPIO=3Dy
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=3Dm
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_CEC_CORE=3Dm
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=3Dm

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=3Dy
CONFIG_MEDIA_ANALOG_TV_SUPPORT=3Dy
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=3Dy
CONFIG_MEDIA_RADIO_SUPPORT=3Dy
# CONFIG_MEDIA_SDR_SUPPORT is not set
CONFIG_MEDIA_CEC_SUPPORT=3Dy
CONFIG_MEDIA_CONTROLLER=3Dy
CONFIG_MEDIA_CONTROLLER_DVB=3Dy
CONFIG_VIDEO_DEV=3Dm
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=3Dm
CONFIG_VIDEO_V4L2_I2C=3Dy
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=3Dm
CONFIG_VIDEOBUF_GEN=3Dm
CONFIG_VIDEOBUF_DMA_SG=3Dm
CONFIG_VIDEOBUF_VMALLOC=3Dm
CONFIG_DVB_CORE=3Dm
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=3Dy
CONFIG_TTPCI_EEPROM=3Dm
CONFIG_DVB_MAX_ADAPTERS=3D8
CONFIG_DVB_DYNAMIC_MINORS=3Dy
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=3Dy

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=3Dm
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=3Dy
CONFIG_USB_GSPCA=3Dm
CONFIG_USB_M5602=3Dm
CONFIG_USB_STV06XX=3Dm
CONFIG_USB_GL860=3Dm
CONFIG_USB_GSPCA_BENQ=3Dm
CONFIG_USB_GSPCA_CONEX=3Dm
CONFIG_USB_GSPCA_CPIA1=3Dm
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=3Dm
CONFIG_USB_GSPCA_FINEPIX=3Dm
CONFIG_USB_GSPCA_JEILINJ=3Dm
CONFIG_USB_GSPCA_JL2005BCD=3Dm
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=3Dm
CONFIG_USB_GSPCA_MARS=3Dm
CONFIG_USB_GSPCA_MR97310A=3Dm
CONFIG_USB_GSPCA_NW80X=3Dm
CONFIG_USB_GSPCA_OV519=3Dm
CONFIG_USB_GSPCA_OV534=3Dm
CONFIG_USB_GSPCA_OV534_9=3Dm
CONFIG_USB_GSPCA_PAC207=3Dm
CONFIG_USB_GSPCA_PAC7302=3Dm
CONFIG_USB_GSPCA_PAC7311=3Dm
CONFIG_USB_GSPCA_SE401=3Dm
CONFIG_USB_GSPCA_SN9C2028=3Dm
CONFIG_USB_GSPCA_SN9C20X=3Dm
CONFIG_USB_GSPCA_SONIXB=3Dm
CONFIG_USB_GSPCA_SONIXJ=3Dm
CONFIG_USB_GSPCA_SPCA500=3Dm
CONFIG_USB_GSPCA_SPCA501=3Dm
CONFIG_USB_GSPCA_SPCA505=3Dm
CONFIG_USB_GSPCA_SPCA506=3Dm
CONFIG_USB_GSPCA_SPCA508=3Dm
CONFIG_USB_GSPCA_SPCA561=3Dm
CONFIG_USB_GSPCA_SPCA1528=3Dm
CONFIG_USB_GSPCA_SQ905=3Dm
CONFIG_USB_GSPCA_SQ905C=3Dm
CONFIG_USB_GSPCA_SQ930X=3Dm
CONFIG_USB_GSPCA_STK014=3Dm
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=3Dm
CONFIG_USB_GSPCA_SUNPLUS=3Dm
CONFIG_USB_GSPCA_T613=3Dm
CONFIG_USB_GSPCA_TOPRO=3Dm
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=3Dm
CONFIG_USB_GSPCA_VC032X=3Dm
CONFIG_USB_GSPCA_VICAM=3Dm
CONFIG_USB_GSPCA_XIRLINK_CIT=3Dm
CONFIG_USB_GSPCA_ZC3XX=3Dm
CONFIG_USB_PWC=3Dm
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=3Dy
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=3Dm
CONFIG_USB_STKWEBCAM=3Dm
CONFIG_USB_S2255=3Dm
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=3Dm
CONFIG_VIDEO_PVRUSB2_SYSFS=3Dy
CONFIG_VIDEO_PVRUSB2_DVB=3Dy
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=3Dm
CONFIG_VIDEO_USBVISION=3Dm
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=3Dm
CONFIG_VIDEO_AU0828_V4L2=3Dy
CONFIG_VIDEO_CX231XX=3Dm
CONFIG_VIDEO_CX231XX_ALSA=3Dm
CONFIG_VIDEO_CX231XX_DVB=3Dm

#
# Digital TV USB devices
#
CONFIG_DVB_USB_V2=3Dm
CONFIG_DVB_USB_AF9015=3Dm
CONFIG_DVB_USB_AF9035=3Dm
CONFIG_DVB_USB_ANYSEE=3Dm
CONFIG_DVB_USB_AU6610=3Dm
CONFIG_DVB_USB_AZ6007=3Dm
CONFIG_DVB_USB_CE6230=3Dm
CONFIG_DVB_USB_EC168=3Dm
CONFIG_DVB_USB_GL861=3Dm
CONFIG_DVB_USB_MXL111SF=3Dm
CONFIG_DVB_USB_RTL28XXU=3Dm
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=3Dm
CONFIG_DVB_TTUSB_DEC=3Dm
CONFIG_SMS_USB_DRV=3Dm
CONFIG_DVB_B2C2_FLEXCOP_USB=3Dm
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=3Dm
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=3Dm
CONFIG_VIDEO_EM28XX_DVB=3Dm

#
# USB HDMI CEC adapters
#
CONFIG_USB_PULSE8_CEC=3Dm
CONFIG_USB_RAINSHADOW_CEC=3Dm
CONFIG_MEDIA_PCI_SUPPORT=3Dy

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set

#
# Media capture/analog TV support
#
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_SAA7134=3Dm
CONFIG_VIDEO_SAA7134_ALSA=3Dm
CONFIG_VIDEO_SAA7134_DVB=3Dm
CONFIG_VIDEO_SAA7164=3Dm

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110=3Dm
CONFIG_DVB_AV7110_OSD=3Dy
CONFIG_DVB_BUDGET_CORE=3Dm
CONFIG_DVB_BUDGET=3Dm
CONFIG_DVB_BUDGET_AV=3Dm
CONFIG_DVB_BUDGET_PATCH=3Dm
CONFIG_DVB_B2C2_FLEXCOP_PCI=3Dm
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=3Dm
CONFIG_DVB_PT1=3Dm
# CONFIG_DVB_PT3 is not set
CONFIG_DVB_NGENE=3Dm
CONFIG_DVB_DDBRIDGE=3Dm
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
CONFIG_CEC_PLATFORM_DRIVERS=3Dy
# CONFIG_VIDEO_SECO_CEC is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=3Dm
CONFIG_RADIO_ADAPTERS=3Dy
CONFIG_RADIO_TEA575X=3Dm
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#
# end of Texas Instruments WL128x FM driver (ST based)

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=3Dm
CONFIG_DVB_FIREDTV_INPUT=3Dy
CONFIG_MEDIA_COMMON_OPTIONS=3Dy

#
# common driver options
#
CONFIG_VIDEO_CX2341X=3Dm
CONFIG_VIDEO_TVEEPROM=3Dm
CONFIG_CYPRESS_FIRMWARE=3Dm
CONFIG_VIDEOBUF2_CORE=3Dm
CONFIG_VIDEOBUF2_V4L2=3Dm
CONFIG_VIDEOBUF2_MEMOPS=3Dm
CONFIG_VIDEOBUF2_VMALLOC=3Dm
CONFIG_VIDEOBUF2_DMA_SG=3Dm
CONFIG_VIDEOBUF2_DVB=3Dm
CONFIG_DVB_B2C2_FLEXCOP=3Dm
CONFIG_VIDEO_SAA7146=3Dm
CONFIG_VIDEO_SAA7146_VV=3Dm
CONFIG_SMS_SIANO_MDTV=3Dm
# CONFIG_SMS_SIANO_DEBUGFS is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=3Dy
CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=3Dy
CONFIG_MEDIA_ATTACH=3Dy

#
# I2C drivers hidden by 'Autoselect ancillary drivers'
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_MSP3400=3Dm
CONFIG_VIDEO_CS53L32A=3Dm
CONFIG_VIDEO_WM8775=3Dm

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=3Dm

#
# Video decoders
#
CONFIG_VIDEO_SAA711X=3Dm

#
# Video and audio decoders
#
CONFIG_VIDEO_CX25840=3Dm

#
# Video encoders
#

#
# Camera sensor devices
#

#
# Lens drivers
#

#
# Flash devices
#

#
# Video improvement chips
#

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=3Dm

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#

#
# SPI drivers hidden by 'Autoselect ancillary drivers'
#

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=3Dm

#
# Tuner drivers hidden by 'Autoselect ancillary drivers'
#
CONFIG_MEDIA_TUNER_SIMPLE=3Dm
CONFIG_MEDIA_TUNER_TDA8290=3Dm
CONFIG_MEDIA_TUNER_TDA827X=3Dm
CONFIG_MEDIA_TUNER_TDA18271=3Dm
CONFIG_MEDIA_TUNER_TDA9887=3Dm
CONFIG_MEDIA_TUNER_TEA5761=3Dm
CONFIG_MEDIA_TUNER_TEA5767=3Dm
CONFIG_MEDIA_TUNER_MT20XX=3Dm
CONFIG_MEDIA_TUNER_MT2060=3Dm
CONFIG_MEDIA_TUNER_MT2063=3Dm
CONFIG_MEDIA_TUNER_MT2131=3Dm
CONFIG_MEDIA_TUNER_QT1010=3Dm
CONFIG_MEDIA_TUNER_XC2028=3Dm
CONFIG_MEDIA_TUNER_XC5000=3Dm
CONFIG_MEDIA_TUNER_XC4000=3Dm
CONFIG_MEDIA_TUNER_MXL5005S=3Dm
CONFIG_MEDIA_TUNER_MXL5007T=3Dm
CONFIG_MEDIA_TUNER_MC44S803=3Dm
CONFIG_MEDIA_TUNER_TDA18218=3Dm
CONFIG_MEDIA_TUNER_FC0011=3Dm
CONFIG_MEDIA_TUNER_FC0012=3Dm
CONFIG_MEDIA_TUNER_FC0013=3Dm
CONFIG_MEDIA_TUNER_TDA18212=3Dm
CONFIG_MEDIA_TUNER_E4000=3Dm
CONFIG_MEDIA_TUNER_FC2580=3Dm
CONFIG_MEDIA_TUNER_TUA9001=3Dm
CONFIG_MEDIA_TUNER_SI2157=3Dm
CONFIG_MEDIA_TUNER_IT913X=3Dm
CONFIG_MEDIA_TUNER_R820T=3Dm
CONFIG_MEDIA_TUNER_QM1D1C0042=3Dm
CONFIG_MEDIA_TUNER_QM1D1B0004=3Dm

#
# DVB Frontend drivers hidden by 'Autoselect ancillary drivers'
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=3Dm
CONFIG_DVB_STV090x=3Dm
CONFIG_DVB_STV0910=3Dm
CONFIG_DVB_STV6110x=3Dm
CONFIG_DVB_STV6111=3Dm
CONFIG_DVB_MXL5XX=3Dm
CONFIG_DVB_M88DS3103=3Dm

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=3Dm
CONFIG_DVB_TDA18271C2DD=3Dm
CONFIG_DVB_SI2165=3Dm
CONFIG_DVB_MN88472=3Dm
CONFIG_DVB_MN88473=3Dm

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24123=3Dm
CONFIG_DVB_MT312=3Dm
CONFIG_DVB_ZL10036=3Dm
CONFIG_DVB_ZL10039=3Dm
CONFIG_DVB_S5H1420=3Dm
CONFIG_DVB_STV0299=3Dm
CONFIG_DVB_STV6110=3Dm
CONFIG_DVB_STV0900=3Dm
CONFIG_DVB_TDA8083=3Dm
CONFIG_DVB_TDA10086=3Dm
CONFIG_DVB_TDA8261=3Dm
CONFIG_DVB_VES1X93=3Dm
CONFIG_DVB_TUNER_ITD1000=3Dm
CONFIG_DVB_TUNER_CX24113=3Dm
CONFIG_DVB_TDA826X=3Dm
CONFIG_DVB_TUA6100=3Dm
CONFIG_DVB_CX24116=3Dm
CONFIG_DVB_CX24120=3Dm
CONFIG_DVB_TS2020=3Dm
CONFIG_DVB_TDA10071=3Dm

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=3Dm
CONFIG_DVB_CX22700=3Dm
CONFIG_DVB_DRXD=3Dm
CONFIG_DVB_L64781=3Dm
CONFIG_DVB_TDA1004X=3Dm
CONFIG_DVB_MT352=3Dm
CONFIG_DVB_ZL10353=3Dm
CONFIG_DVB_TDA10048=3Dm
CONFIG_DVB_AF9013=3Dm
CONFIG_DVB_EC100=3Dm
CONFIG_DVB_STV0367=3Dm
CONFIG_DVB_CXD2820R=3Dm
CONFIG_DVB_CXD2841ER=3Dm
CONFIG_DVB_RTL2830=3Dm
CONFIG_DVB_RTL2832=3Dm
CONFIG_DVB_SI2168=3Dm

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=3Dm
CONFIG_DVB_TDA10021=3Dm
CONFIG_DVB_TDA10023=3Dm
CONFIG_DVB_STV0297=3Dm

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=3Dm
CONFIG_DVB_BCM3510=3Dm
CONFIG_DVB_LGDT330X=3Dm
CONFIG_DVB_LGDT3305=3Dm
CONFIG_DVB_LGDT3306A=3Dm
CONFIG_DVB_LG2160=3Dm
CONFIG_DVB_S5H1409=3Dm
CONFIG_DVB_AU8522=3Dm
CONFIG_DVB_AU8522_DTV=3Dm
CONFIG_DVB_AU8522_V4L=3Dm
CONFIG_DVB_S5H1411=3Dm

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=3Dm
CONFIG_DVB_MB86A20S=3Dm

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=3Dm

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=3Dm

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=3Dm
CONFIG_DVB_LNBH25=3Dm
CONFIG_DVB_LNBP21=3Dm
CONFIG_DVB_ISL6405=3Dm
CONFIG_DVB_ISL6421=3Dm
CONFIG_DVB_ISL6423=3Dm
CONFIG_DVB_A8293=3Dm
CONFIG_DVB_AF9033=3Dm

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=3Dm

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=3Dm

#
# Graphics support
#
CONFIG_AGP=3Dy
CONFIG_AGP_AMD64=3Dy
CONFIG_AGP_INTEL=3Dy
CONFIG_AGP_SIS=3Dy
CONFIG_AGP_VIA=3Dy
CONFIG_INTEL_GTT=3Dy
CONFIG_VGA_ARB=3Dy
CONFIG_VGA_ARB_MAX_GPUS=3D64
CONFIG_VGA_SWITCHEROO=3Dy
CONFIG_DRM=3Dm
CONFIG_DRM_MIPI_DSI=3Dy
CONFIG_DRM_DP_AUX_CHARDEV=3Dy
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=3Dm
CONFIG_DRM_KMS_FB_HELPER=3Dy
CONFIG_DRM_FBDEV_EMULATION=3Dy
CONFIG_DRM_FBDEV_OVERALLOC=3D100
CONFIG_DRM_LOAD_EDID_FIRMWARE=3Dy
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=3Dm
CONFIG_DRM_VRAM_HELPER=3Dm
CONFIG_DRM_GEM_SHMEM_HELPER=3Dy
CONFIG_DRM_VM=3Dy
CONFIG_DRM_SCHED=3Dm

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=3Dm
CONFIG_DRM_I2C_SIL164=3Dm
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

CONFIG_DRM_RADEON=3Dm
CONFIG_DRM_RADEON_USERPTR=3Dy
CONFIG_DRM_AMDGPU=3Dm
# CONFIG_DRM_AMDGPU_SI is not set
# CONFIG_DRM_AMDGPU_CIK is not set
# CONFIG_DRM_AMDGPU_USERPTR is not set
# CONFIG_DRM_AMDGPU_GART_DEBUGFS is not set

#
# ACP (Audio CoProcessor) Configuration
#
CONFIG_DRM_AMD_ACP=3Dy
# end of ACP (Audio CoProcessor) Configuration

#
# Display Engine Configuration
#
CONFIG_DRM_AMD_DC=3Dy
CONFIG_DRM_AMD_DC_DCN1_0=3Dy
CONFIG_DRM_AMD_DC_DCN2_0=3Dy
CONFIG_DRM_AMD_DC_DCN2_1=3Dy
CONFIG_DRM_AMD_DC_DSC_SUPPORT=3Dy
# CONFIG_DEBUG_KERNEL_DC is not set
# end of Display Engine Configuration

CONFIG_HSA_AMD=3Dy
CONFIG_DRM_NOUVEAU=3Dm
CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT=3Dy
CONFIG_NOUVEAU_DEBUG=3D5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3D3
# CONFIG_NOUVEAU_DEBUG_MMU is not set
CONFIG_DRM_NOUVEAU_BACKLIGHT=3Dy
CONFIG_DRM_I915=3Dm
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_FORCE_PROBE=3D""
CONFIG_DRM_I915_CAPTURE_ERROR=3Dy
CONFIG_DRM_I915_COMPRESS_ERROR=3Dy
CONFIG_DRM_I915_USERPTR=3Dy
CONFIG_DRM_I915_GVT=3Dy
CONFIG_DRM_I915_GVT_KVMGT=3Dm
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=3D250
CONFIG_DRM_I915_SPIN_REQUEST=3D5
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_ATI_PCIGART=3Dy
CONFIG_DRM_VMWGFX=3Dm
CONFIG_DRM_VMWGFX_FBCON=3Dy
CONFIG_DRM_GMA500=3Dm
CONFIG_DRM_GMA600=3Dy
CONFIG_DRM_GMA3600=3Dy
CONFIG_DRM_UDL=3Dm
CONFIG_DRM_AST=3Dm
CONFIG_DRM_MGAG200=3Dm
CONFIG_DRM_CIRRUS_QEMU=3Dm
CONFIG_DRM_QXL=3Dm
CONFIG_DRM_BOCHS=3Dm
CONFIG_DRM_VIRTIO_GPU=3Dm
CONFIG_DRM_PANEL=3Dy

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=3Dy
CONFIG_DRM_PANEL_BRIDGE=3Dy

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_GM12U320=3Dm
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
CONFIG_DRM_LEGACY=3Dy
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=3Dy

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=3Dy
CONFIG_FB_NOTIFY=3Dy
CONFIG_FB=3Dy
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=3Dy
CONFIG_FB_CFB_FILLRECT=3Dy
CONFIG_FB_CFB_COPYAREA=3Dy
CONFIG_FB_CFB_IMAGEBLIT=3Dy
CONFIG_FB_SYS_FILLRECT=3Dm
CONFIG_FB_SYS_COPYAREA=3Dm
CONFIG_FB_SYS_IMAGEBLIT=3Dm
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=3Dm
CONFIG_FB_DEFERRED_IO=3Dy
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=3Dy

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=3Dy
CONFIG_FB_EFI=3Dy
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=3Dm
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=3Dm
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=3Dm
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=3Dm
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=3Dm
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=3Dy

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
CONFIG_VGACON_SOFT_SCROLLBACK=3Dy
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=3D64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_DUMMY_CONSOLE_COLUMNS=3D80
CONFIG_DUMMY_CONSOLE_ROWS=3D25
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=3Dy
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=3Dy
# end of Graphics support

CONFIG_SOUND=3Dm
CONFIG_SOUND_OSS_CORE=3Dy
CONFIG_SOUND_OSS_CORE_PRECLAIM=3Dy
CONFIG_SND=3Dm
CONFIG_SND_TIMER=3Dm
CONFIG_SND_PCM=3Dm
CONFIG_SND_PCM_ELD=3Dy
CONFIG_SND_HWDEP=3Dm
CONFIG_SND_SEQ_DEVICE=3Dm
CONFIG_SND_RAWMIDI=3Dm
CONFIG_SND_COMPRESS_OFFLOAD=3Dm
CONFIG_SND_JACK=3Dy
CONFIG_SND_JACK_INPUT_DEV=3Dy
CONFIG_SND_OSSEMUL=3Dy
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=3Dy
CONFIG_SND_HRTIMER=3Dm
CONFIG_SND_DYNAMIC_MINORS=3Dy
CONFIG_SND_MAX_CARDS=3D32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=3Dy
CONFIG_SND_VERBOSE_PROCFS=3Dy
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=3Dy
CONFIG_SND_DMA_SGBUF=3Dy
CONFIG_SND_SEQUENCER=3Dm
CONFIG_SND_SEQ_DUMMY=3Dm
CONFIG_SND_SEQUENCER_OSS=3Dm
CONFIG_SND_SEQ_HRTIMER_DEFAULT=3Dy
CONFIG_SND_SEQ_MIDI_EVENT=3Dm
CONFIG_SND_SEQ_MIDI=3Dm
CONFIG_SND_SEQ_MIDI_EMUL=3Dm
CONFIG_SND_SEQ_VIRMIDI=3Dm
CONFIG_SND_MPU401_UART=3Dm
CONFIG_SND_OPL3_LIB=3Dm
CONFIG_SND_OPL3_LIB_SEQ=3Dm
CONFIG_SND_VX_LIB=3Dm
CONFIG_SND_AC97_CODEC=3Dm
CONFIG_SND_DRIVERS=3Dy
CONFIG_SND_PCSP=3Dm
CONFIG_SND_DUMMY=3Dm
CONFIG_SND_ALOOP=3Dm
CONFIG_SND_VIRMIDI=3Dm
CONFIG_SND_MTPAV=3Dm
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=3Dm
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=3Dy
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=3D5
CONFIG_SND_PCI=3Dy
CONFIG_SND_AD1889=3Dm
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=3Dm
CONFIG_SND_ASIHPI=3Dm
CONFIG_SND_ATIIXP=3Dm
CONFIG_SND_ATIIXP_MODEM=3Dm
CONFIG_SND_AU8810=3Dm
CONFIG_SND_AU8820=3Dm
CONFIG_SND_AU8830=3Dm
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=3Dm
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=3Dm
CONFIG_SND_CMIPCI=3Dm
CONFIG_SND_OXYGEN_LIB=3Dm
CONFIG_SND_OXYGEN=3Dm
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=3Dm
CONFIG_SND_CS46XX_NEW_DSP=3Dy
CONFIG_SND_CTXFI=3Dm
CONFIG_SND_DARLA20=3Dm
CONFIG_SND_GINA20=3Dm
CONFIG_SND_LAYLA20=3Dm
CONFIG_SND_DARLA24=3Dm
CONFIG_SND_GINA24=3Dm
CONFIG_SND_LAYLA24=3Dm
CONFIG_SND_MONA=3Dm
CONFIG_SND_MIA=3Dm
CONFIG_SND_ECHO3G=3Dm
CONFIG_SND_INDIGO=3Dm
CONFIG_SND_INDIGOIO=3Dm
CONFIG_SND_INDIGODJ=3Dm
CONFIG_SND_INDIGOIOX=3Dm
CONFIG_SND_INDIGODJX=3Dm
CONFIG_SND_EMU10K1=3Dm
CONFIG_SND_EMU10K1_SEQ=3Dm
CONFIG_SND_EMU10K1X=3Dm
CONFIG_SND_ENS1370=3Dm
CONFIG_SND_ENS1371=3Dm
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=3Dm
CONFIG_SND_ES1968_INPUT=3Dy
CONFIG_SND_ES1968_RADIO=3Dy
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=3Dm
CONFIG_SND_HDSPM=3Dm
CONFIG_SND_ICE1712=3Dm
CONFIG_SND_ICE1724=3Dm
CONFIG_SND_INTEL8X0=3Dm
CONFIG_SND_INTEL8X0M=3Dm
CONFIG_SND_KORG1212=3Dm
CONFIG_SND_LOLA=3Dm
CONFIG_SND_LX6464ES=3Dm
CONFIG_SND_MAESTRO3=3Dm
CONFIG_SND_MAESTRO3_INPUT=3Dy
CONFIG_SND_MIXART=3Dm
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=3Dm
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=3Dm
CONFIG_SND_RME96=3Dm
CONFIG_SND_RME9652=3Dm
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=3Dm
CONFIG_SND_VIA82XX=3Dm
CONFIG_SND_VIA82XX_MODEM=3Dm
CONFIG_SND_VIRTUOSO=3Dm
CONFIG_SND_VX222=3Dm
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=3Dm
CONFIG_SND_HDA_INTEL=3Dm
CONFIG_SND_HDA_INTEL_DETECT_DMIC=3Dy
CONFIG_SND_HDA_HWDEP=3Dy
CONFIG_SND_HDA_RECONFIG=3Dy
CONFIG_SND_HDA_INPUT_BEEP=3Dy
CONFIG_SND_HDA_INPUT_BEEP_MODE=3D0
CONFIG_SND_HDA_PATCH_LOADER=3Dy
CONFIG_SND_HDA_CODEC_REALTEK=3Dm
CONFIG_SND_HDA_CODEC_ANALOG=3Dm
CONFIG_SND_HDA_CODEC_SIGMATEL=3Dm
CONFIG_SND_HDA_CODEC_VIA=3Dm
CONFIG_SND_HDA_CODEC_HDMI=3Dm
CONFIG_SND_HDA_CODEC_CIRRUS=3Dm
CONFIG_SND_HDA_CODEC_CONEXANT=3Dm
CONFIG_SND_HDA_CODEC_CA0110=3Dm
CONFIG_SND_HDA_CODEC_CA0132=3Dm
CONFIG_SND_HDA_CODEC_CA0132_DSP=3Dy
CONFIG_SND_HDA_CODEC_CMEDIA=3Dm
CONFIG_SND_HDA_CODEC_SI3054=3Dm
CONFIG_SND_HDA_GENERIC=3Dm
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=3D0
# end of HD-Audio

CONFIG_SND_HDA_CORE=3Dm
CONFIG_SND_HDA_DSP_LOADER=3Dy
CONFIG_SND_HDA_COMPONENT=3Dy
CONFIG_SND_HDA_I915=3Dy
CONFIG_SND_HDA_EXT_CORE=3Dm
CONFIG_SND_HDA_PREALLOC_SIZE=3D512
CONFIG_SND_INTEL_NHLT=3Dm
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=3Dy
CONFIG_SND_USB_AUDIO=3Dm
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=3Dy
CONFIG_SND_USB_UA101=3Dm
CONFIG_SND_USB_USX2Y=3Dm
CONFIG_SND_USB_CAIAQ=3Dm
CONFIG_SND_USB_CAIAQ_INPUT=3Dy
CONFIG_SND_USB_US122L=3Dm
CONFIG_SND_USB_6FIRE=3Dm
CONFIG_SND_USB_HIFACE=3Dm
CONFIG_SND_BCD2000=3Dm
CONFIG_SND_USB_LINE6=3Dm
CONFIG_SND_USB_POD=3Dm
CONFIG_SND_USB_PODHD=3Dm
CONFIG_SND_USB_TONEPORT=3Dm
CONFIG_SND_USB_VARIAX=3Dm
CONFIG_SND_FIREWIRE=3Dy
CONFIG_SND_FIREWIRE_LIB=3Dm
CONFIG_SND_DICE=3Dm
CONFIG_SND_OXFW=3Dm
CONFIG_SND_ISIGHT=3Dm
CONFIG_SND_FIREWORKS=3Dm
CONFIG_SND_BEBOB=3Dm
CONFIG_SND_FIREWIRE_DIGI00X=3Dm
CONFIG_SND_FIREWIRE_TASCAM=3Dm
CONFIG_SND_FIREWIRE_MOTU=3Dm
CONFIG_SND_FIREFACE=3Dm
CONFIG_SND_SOC=3Dm
CONFIG_SND_SOC_COMPRESS=3Dy
CONFIG_SND_SOC_TOPOLOGY=3Dy
CONFIG_SND_SOC_ACPI=3Dm
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=3Dy
CONFIG_SND_SST_IPC=3Dm
CONFIG_SND_SST_IPC_ACPI=3Dm
CONFIG_SND_SOC_INTEL_SST_ACPI=3Dm
CONFIG_SND_SOC_INTEL_SST=3Dm
CONFIG_SND_SOC_INTEL_SST_FIRMWARE=3Dm
CONFIG_SND_SOC_INTEL_HASWELL=3Dm
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=3Dm
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=3Dm
CONFIG_SND_SOC_INTEL_SKYLAKE=3Dm
CONFIG_SND_SOC_INTEL_SKL=3Dm
CONFIG_SND_SOC_INTEL_APL=3Dm
CONFIG_SND_SOC_INTEL_KBL=3Dm
CONFIG_SND_SOC_INTEL_GLK=3Dm
CONFIG_SND_SOC_INTEL_CNL=3Dm
CONFIG_SND_SOC_INTEL_CFL=3Dm
# CONFIG_SND_SOC_INTEL_CML_H is not set
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=3Dm
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=3Dm
CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC=3Dy
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=3Dm
CONFIG_SND_SOC_ACPI_INTEL_MATCH=3Dm
CONFIG_SND_SOC_INTEL_MACH=3Dy
# CONFIG_SND_SOC_INTEL_HASWELL_MACH is not set
# CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH is not set
# CONFIG_SND_SOC_INTEL_BROADWELL_MACH is not set
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=3Dm
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=3Dm
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=3Dm
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=3Dm
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=3Dm
CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH=3Dm
# CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH is not set
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=3Dm
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=3Dm
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=3Dm
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=3Dm
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=3Dm
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=3Dm
CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=3Dm
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=3Dm
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=3Dm
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=3Dm
CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=3Dm
CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH=3Dm
CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH=3Dm
CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH=3Dm
CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH=3Dm
CONFIG_SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=3Dm
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=3Dm

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
# CONFIG_SND_SOC_CX2072X is not set
CONFIG_SND_SOC_DA7213=3Dm
CONFIG_SND_SOC_DA7219=3Dm
CONFIG_SND_SOC_DMIC=3Dm
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=3Dm
# CONFIG_SND_SOC_ES8328_I2C is not set
# CONFIG_SND_SOC_ES8328_SPI is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDMI=3Dm
CONFIG_SND_SOC_HDAC_HDA=3Dm
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=3Dm
CONFIG_SND_SOC_MAX98357A=3Dm
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=3Dm
CONFIG_SND_SOC_MAX98373=3Dm
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM186X_SPI is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=3Dm
CONFIG_SND_SOC_RL6347A=3Dm
CONFIG_SND_SOC_RT286=3Dm
CONFIG_SND_SOC_RT298=3Dm
CONFIG_SND_SOC_RT5514=3Dm
CONFIG_SND_SOC_RT5514_SPI=3Dm
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=3Dm
CONFIG_SND_SOC_RT5645=3Dm
CONFIG_SND_SOC_RT5651=3Dm
CONFIG_SND_SOC_RT5660=3Dm
CONFIG_SND_SOC_RT5663=3Dm
CONFIG_SND_SOC_RT5670=3Dm
CONFIG_SND_SOC_RT5682=3Dm
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=3Dm
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
# CONFIG_SND_SOC_TLV320AIC3X is not set
CONFIG_SND_SOC_TS3A227E=3Dm
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_UDA1334 is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=3Dm
CONFIG_SND_SOC_NAU8825=3Dm
# CONFIG_SND_SOC_TPA6130A2 is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=3Dy
CONFIG_HDMI_LPE_AUDIO=3Dm
CONFIG_SND_SYNTH_EMUX=3Dm
# CONFIG_SND_XEN_FRONTEND is not set
CONFIG_AC97_BUS=3Dm

#
# HID support
#
CONFIG_HID=3Dy
CONFIG_HID_BATTERY_STRENGTH=3Dy
CONFIG_HIDRAW=3Dy
CONFIG_UHID=3Dm
CONFIG_HID_GENERIC=3Dy

#
# Special HID drivers
#
CONFIG_HID_A4TECH=3Dm
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=3Dm
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=3Dm
CONFIG_HID_APPLEIR=3Dm
CONFIG_HID_ASUS=3Dm
CONFIG_HID_AUREAL=3Dm
CONFIG_HID_BELKIN=3Dm
CONFIG_HID_BETOP_FF=3Dm
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=3Dm
CONFIG_HID_CHICONY=3Dm
CONFIG_HID_CORSAIR=3Dm
CONFIG_HID_COUGAR=3Dm
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=3Dm
CONFIG_HID_CMEDIA=3Dm
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=3Dm
CONFIG_HID_DRAGONRISE=3Dm
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELAN=3Dm
CONFIG_HID_ELECOM=3Dm
CONFIG_HID_ELO=3Dm
CONFIG_HID_EZKEY=3Dm
CONFIG_HID_GEMBIRD=3Dm
CONFIG_HID_GFRM=3Dm
CONFIG_HID_HOLTEK=3Dm
# CONFIG_HOLTEK_FF is not set
CONFIG_HID_GT683R=3Dm
CONFIG_HID_KEYTOUCH=3Dm
CONFIG_HID_KYE=3Dm
CONFIG_HID_UCLOGIC=3Dm
CONFIG_HID_WALTOP=3Dm
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=3Dm
CONFIG_HID_ICADE=3Dm
CONFIG_HID_ITE=3Dm
CONFIG_HID_JABRA=3Dm
CONFIG_HID_TWINHAN=3Dm
CONFIG_HID_KENSINGTON=3Dm
CONFIG_HID_LCPOWER=3Dm
CONFIG_HID_LED=3Dm
CONFIG_HID_LENOVO=3Dm
CONFIG_HID_LOGITECH=3Dm
CONFIG_HID_LOGITECH_DJ=3Dm
CONFIG_HID_LOGITECH_HIDPP=3Dm
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=3Dy
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=3Dm
CONFIG_HID_MONTEREY=3Dm
CONFIG_HID_MULTITOUCH=3Dm
CONFIG_HID_NTI=3Dm
CONFIG_HID_NTRIG=3Dy
CONFIG_HID_ORTEK=3Dm
CONFIG_HID_PANTHERLORD=3Dm
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PENMOUNT=3Dm
CONFIG_HID_PETALYNX=3Dm
CONFIG_HID_PICOLCD=3Dm
CONFIG_HID_PICOLCD_FB=3Dy
CONFIG_HID_PICOLCD_BACKLIGHT=3Dy
CONFIG_HID_PICOLCD_LCD=3Dy
CONFIG_HID_PICOLCD_LEDS=3Dy
CONFIG_HID_PLANTRONICS=3Dm
CONFIG_HID_PRIMAX=3Dm
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=3Dm
CONFIG_HID_SAITEK=3Dm
CONFIG_HID_SAMSUNG=3Dm
CONFIG_HID_SONY=3Dm
CONFIG_SONY_FF=3Dy
CONFIG_HID_SPEEDLINK=3Dm
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=3Dm
CONFIG_HID_SUNPLUS=3Dm
CONFIG_HID_RMI=3Dm
CONFIG_HID_GREENASIA=3Dm
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=3Dm
CONFIG_HID_SMARTJOYPLUS=3Dm
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=3Dm
CONFIG_HID_TOPSEED=3Dm
CONFIG_HID_THINGM=3Dm
CONFIG_HID_THRUSTMASTER=3Dm
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
CONFIG_HID_WACOM=3Dm
CONFIG_HID_WIIMOTE=3Dm
CONFIG_HID_XINMO=3Dm
CONFIG_HID_ZEROPLUS=3Dm
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=3Dm
CONFIG_HID_SENSOR_HUB=3Dy
CONFIG_HID_SENSOR_CUSTOM_SENSOR=3Dm
CONFIG_HID_ALPS=3Dm
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=3Dy
CONFIG_HID_PID=3Dy
CONFIG_USB_HIDDEV=3Dy
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=3Dm
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=3Dm
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
CONFIG_USB_SUPPORT=3Dy
CONFIG_USB_COMMON=3Dy
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB=3Dy
CONFIG_USB_PCI=3Dy
CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=3Dy
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=3Dm
CONFIG_USB_AUTOSUSPEND_DELAY=3D2
CONFIG_USB_MON=3Dy

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=3Dy
CONFIG_USB_XHCI_DBGCAP=3Dy
CONFIG_USB_XHCI_PCI=3Dy
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=3Dy
CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
CONFIG_USB_EHCI_TT_NEWSCHED=3Dy
CONFIG_USB_EHCI_PCI=3Dy
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=3Dy
CONFIG_USB_OHCI_HCD_PCI=3Dy
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=3Dy
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=3Dm
CONFIG_USB_PRINTER=3Dm
CONFIG_USB_WDM=3Dm
CONFIG_USB_TMC=3Dm

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=3Dm
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=3Dm
CONFIG_REALTEK_AUTOPM=3Dy
CONFIG_USB_STORAGE_DATAFAB=3Dm
CONFIG_USB_STORAGE_FREECOM=3Dm
CONFIG_USB_STORAGE_ISD200=3Dm
CONFIG_USB_STORAGE_USBAT=3Dm
CONFIG_USB_STORAGE_SDDR09=3Dm
CONFIG_USB_STORAGE_SDDR55=3Dm
CONFIG_USB_STORAGE_JUMPSHOT=3Dm
CONFIG_USB_STORAGE_ALAUDA=3Dm
CONFIG_USB_STORAGE_ONETOUCH=3Dm
CONFIG_USB_STORAGE_KARMA=3Dm
CONFIG_USB_STORAGE_CYPRESS_ATACB=3Dm
CONFIG_USB_STORAGE_ENE_UB6250=3Dm
CONFIG_USB_UAS=3Dm

#
# USB Imaging devices
#
CONFIG_USB_MDC800=3Dm
CONFIG_USB_MICROTEK=3Dm
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=3Dm
CONFIG_USB_SERIAL=3Dy
CONFIG_USB_SERIAL_CONSOLE=3Dy
CONFIG_USB_SERIAL_GENERIC=3Dy
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=3Dm
CONFIG_USB_SERIAL_ARK3116=3Dm
CONFIG_USB_SERIAL_BELKIN=3Dm
CONFIG_USB_SERIAL_CH341=3Dm
CONFIG_USB_SERIAL_WHITEHEAT=3Dm
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dm
CONFIG_USB_SERIAL_CP210X=3Dm
CONFIG_USB_SERIAL_CYPRESS_M8=3Dm
CONFIG_USB_SERIAL_EMPEG=3Dm
CONFIG_USB_SERIAL_FTDI_SIO=3Dm
CONFIG_USB_SERIAL_VISOR=3Dm
CONFIG_USB_SERIAL_IPAQ=3Dm
CONFIG_USB_SERIAL_IR=3Dm
CONFIG_USB_SERIAL_EDGEPORT=3Dm
CONFIG_USB_SERIAL_EDGEPORT_TI=3Dm
# CONFIG_USB_SERIAL_F81232 is not set
CONFIG_USB_SERIAL_F8153X=3Dm
CONFIG_USB_SERIAL_GARMIN=3Dm
CONFIG_USB_SERIAL_IPW=3Dm
CONFIG_USB_SERIAL_IUU=3Dm
CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dm
CONFIG_USB_SERIAL_KEYSPAN=3Dm
CONFIG_USB_SERIAL_KLSI=3Dm
CONFIG_USB_SERIAL_KOBIL_SCT=3Dm
CONFIG_USB_SERIAL_MCT_U232=3Dm
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=3Dm
CONFIG_USB_SERIAL_MOS7715_PARPORT=3Dy
CONFIG_USB_SERIAL_MOS7840=3Dm
CONFIG_USB_SERIAL_MXUPORT=3Dm
CONFIG_USB_SERIAL_NAVMAN=3Dm
CONFIG_USB_SERIAL_PL2303=3Dm
CONFIG_USB_SERIAL_OTI6858=3Dm
CONFIG_USB_SERIAL_QCAUX=3Dm
CONFIG_USB_SERIAL_QUALCOMM=3Dm
CONFIG_USB_SERIAL_SPCP8X5=3Dm
CONFIG_USB_SERIAL_SAFE=3Dm
CONFIG_USB_SERIAL_SAFE_PADDED=3Dy
CONFIG_USB_SERIAL_SIERRAWIRELESS=3Dm
CONFIG_USB_SERIAL_SYMBOL=3Dm
CONFIG_USB_SERIAL_TI=3Dm
CONFIG_USB_SERIAL_CYBERJACK=3Dm
CONFIG_USB_SERIAL_XIRCOM=3Dm
CONFIG_USB_SERIAL_WWAN=3Dm
CONFIG_USB_SERIAL_OPTION=3Dm
CONFIG_USB_SERIAL_OMNINET=3Dm
CONFIG_USB_SERIAL_OPTICON=3Dm
CONFIG_USB_SERIAL_XSENS_MT=3Dm
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=3Dm
CONFIG_USB_SERIAL_QT2=3Dm
CONFIG_USB_SERIAL_UPD78F0730=3Dm
CONFIG_USB_SERIAL_DEBUG=3Dm

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=3Dm
CONFIG_USB_EMI26=3Dm
CONFIG_USB_ADUTUX=3Dm
CONFIG_USB_SEVSEG=3Dm
CONFIG_USB_LEGOTOWER=3Dm
CONFIG_USB_LCD=3Dm
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=3Dm
CONFIG_USB_FTDI_ELAN=3Dm
CONFIG_USB_APPLEDISPLAY=3Dm
CONFIG_USB_SISUSBVGA=3Dm
CONFIG_USB_SISUSBVGA_CON=3Dy
CONFIG_USB_LD=3Dm
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=3Dm
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=3Dm
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=3Dm
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=3Dm
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=3Dm
CONFIG_USB_SPEEDTOUCH=3Dm
CONFIG_USB_CXACRU=3Dm
CONFIG_USB_UEAGLEATM=3Dm
CONFIG_USB_XUSBATM=3Dm

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=3Dy
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=3Dy
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=3Dy
# CONFIG_TYPEC_TPS6598X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=3Dm
# CONFIG_TYPEC_NVIDIA_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=3Dm
CONFIG_USB_ROLES_INTEL_XHCI=3Dm
CONFIG_MMC=3Dm
CONFIG_MMC_BLOCK=3Dm
CONFIG_MMC_BLOCK_MINORS=3D8
CONFIG_SDIO_UART=3Dm
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=3Dm
CONFIG_MMC_SDHCI_IO_ACCESSORS=3Dy
CONFIG_MMC_SDHCI_PCI=3Dm
CONFIG_MMC_RICOH_MMC=3Dy
CONFIG_MMC_SDHCI_ACPI=3Dm
CONFIG_MMC_SDHCI_PLTFM=3Dm
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=3Dm
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=3Dm
CONFIG_MMC_VIA_SDMMC=3Dm
CONFIG_MMC_VUB300=3Dm
CONFIG_MMC_USHC=3Dm
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_REALTEK_PCI=3Dm
CONFIG_MMC_REALTEK_USB=3Dm
CONFIG_MMC_CQHCI=3Dm
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=3Dm
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=3Dm
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=3Dm
CONFIG_MEMSTICK_JMICRON_38X=3Dm
CONFIG_MEMSTICK_R592=3Dm
CONFIG_MEMSTICK_REALTEK_PCI=3Dm
CONFIG_MEMSTICK_REALTEK_USB=3Dm
CONFIG_NEW_LEDS=3Dy
CONFIG_LEDS_CLASS=3Dy
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=3Dm
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=3Dm
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=3Dm
CONFIG_LEDS_LP5521=3Dm
CONFIG_LEDS_LP5523=3Dm
CONFIG_LEDS_LP5562=3Dm
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_CLEVO_MAIL=3Dm
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=3Dm
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THI=
NGM)
#
CONFIG_LEDS_BLINKM=3Dm
CONFIG_LEDS_MLXCPLD=3Dm
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=3Dy
CONFIG_LEDS_TRIGGER_TIMER=3Dm
CONFIG_LEDS_TRIGGER_ONESHOT=3Dm
CONFIG_LEDS_TRIGGER_DISK=3Dy
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dm
CONFIG_LEDS_TRIGGER_BACKLIGHT=3Dm
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=3Dm
CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dm

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=3Dm
CONFIG_LEDS_TRIGGER_CAMERA=3Dm
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=3Dm
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=3Dm
CONFIG_INFINIBAND_USER_MAD=3Dm
CONFIG_INFINIBAND_USER_ACCESS=3Dm
# CONFIG_INFINIBAND_EXP_LEGACY_VERBS_NEW_UAPI is not set
CONFIG_INFINIBAND_USER_MEM=3Dy
CONFIG_INFINIBAND_ON_DEMAND_PAGING=3Dy
CONFIG_INFINIBAND_ADDR_TRANS=3Dy
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=3Dy
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_QIB is not set
CONFIG_INFINIBAND_CXGB4=3Dm
CONFIG_INFINIBAND_EFA=3Dm
CONFIG_INFINIBAND_I40IW=3Dm
CONFIG_MLX4_INFINIBAND=3Dm
CONFIG_MLX5_INFINIBAND=3Dm
# CONFIG_INFINIBAND_OCRDMA is not set
CONFIG_INFINIBAND_VMWARE_PVRDMA=3Dm
CONFIG_INFINIBAND_USNIC=3Dm
CONFIG_INFINIBAND_BNXT_RE=3Dm
CONFIG_INFINIBAND_HFI1=3Dm
# CONFIG_HFI1_DEBUG_SDMA_ORDER is not set
# CONFIG_SDMA_VERBOSITY is not set
CONFIG_INFINIBAND_QEDR=3Dm
CONFIG_INFINIBAND_RDMAVT=3Dm
CONFIG_RDMA_RXE=3Dm
CONFIG_RDMA_SIW=3Dm
CONFIG_INFINIBAND_IPOIB=3Dm
CONFIG_INFINIBAND_IPOIB_CM=3Dy
CONFIG_INFINIBAND_IPOIB_DEBUG=3Dy
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=3Dm
CONFIG_INFINIBAND_SRPT=3Dm
CONFIG_INFINIBAND_ISER=3Dm
CONFIG_INFINIBAND_ISERT=3Dm
CONFIG_INFINIBAND_OPA_VNIC=3Dm
CONFIG_EDAC_ATOMIC_SCRUB=3Dy
CONFIG_EDAC_SUPPORT=3Dy
CONFIG_EDAC=3Dy
CONFIG_EDAC_LEGACY_SYSFS=3Dy
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=3Dm
CONFIG_EDAC_GHES=3Dy
CONFIG_EDAC_AMD64=3Dm
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=3Dm
CONFIG_EDAC_I82975X=3Dm
CONFIG_EDAC_I3000=3Dm
CONFIG_EDAC_I3200=3Dm
CONFIG_EDAC_IE31200=3Dm
CONFIG_EDAC_X38=3Dm
CONFIG_EDAC_I5400=3Dm
CONFIG_EDAC_I7CORE=3Dm
CONFIG_EDAC_I5000=3Dm
CONFIG_EDAC_I5100=3Dm
CONFIG_EDAC_I7300=3Dm
CONFIG_EDAC_SBRIDGE=3Dm
CONFIG_EDAC_SKX=3Dm
CONFIG_EDAC_I10NM=3Dm
CONFIG_EDAC_PND2=3Dm
CONFIG_RTC_LIB=3Dy
CONFIG_RTC_MC146818_LIB=3Dy
CONFIG_RTC_CLASS=3Dy
CONFIG_RTC_HCTOSYS=3Dy
CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=3Dy

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=3Dy
CONFIG_RTC_INTF_PROC=3Dy
CONFIG_RTC_INTF_DEV=3Dy
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=3Dm
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=3Dm
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=3Dm
CONFIG_RTC_DRV_MAX6900=3Dm
CONFIG_RTC_DRV_RS5C372=3Dm
CONFIG_RTC_DRV_ISL1208=3Dm
CONFIG_RTC_DRV_ISL12022=3Dm
CONFIG_RTC_DRV_X1205=3Dm
CONFIG_RTC_DRV_PCF8523=3Dm
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=3Dm
CONFIG_RTC_DRV_PCF8583=3Dm
CONFIG_RTC_DRV_M41T80=3Dm
CONFIG_RTC_DRV_M41T80_WDT=3Dy
CONFIG_RTC_DRV_BQ32K=3Dm
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=3Dm
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=3Dm
CONFIG_RTC_DRV_RX8025=3Dm
CONFIG_RTC_DRV_EM3027=3Dm
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=3Dm
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=3Dy

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=3Dm
CONFIG_RTC_DRV_DS3232_HWMON=3Dy
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=3Dm
# CONFIG_RTC_DRV_RV3029_HWMON is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=3Dy
CONFIG_RTC_DRV_DS1286=3Dm
CONFIG_RTC_DRV_DS1511=3Dm
CONFIG_RTC_DRV_DS1553=3Dm
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=3Dm
CONFIG_RTC_DRV_DS2404=3Dm
CONFIG_RTC_DRV_STK17TA8=3Dm
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=3Dm
CONFIG_RTC_DRV_M48T59=3Dm
CONFIG_RTC_DRV_MSM6242=3Dm
CONFIG_RTC_DRV_BQ4802=3Dm
CONFIG_RTC_DRV_RP5C01=3Dm
CONFIG_RTC_DRV_V3020=3Dm

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=3Dy
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=3Dy
CONFIG_DMA_VIRTUAL_CHANNELS=3Dy
CONFIG_DMA_ACPI=3Dy
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=3Dm
CONFIG_INTEL_IOATDMA=3Dm
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=3Dy
CONFIG_DW_DMAC=3Dm
CONFIG_DW_DMAC_PCI=3Dy
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=3Dy

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=3Dy
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=3Dy

#
# DMABUF options
#
CONFIG_SYNC_FILE=3Dy
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_SELFTESTS is not set
# end of DMABUF options

CONFIG_DCA=3Dm
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=3Dm
CONFIG_UIO_CIF=3Dm
CONFIG_UIO_PDRV_GENIRQ=3Dm
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=3Dm
CONFIG_UIO_SERCOS3=3Dm
CONFIG_UIO_PCI_GENERIC=3Dm
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=3Dm
CONFIG_VFIO_IOMMU_TYPE1=3Dm
CONFIG_VFIO_VIRQFD=3Dm
CONFIG_VFIO=3Dm
CONFIG_VFIO_NOIOMMU=3Dy
CONFIG_VFIO_PCI=3Dm
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=3Dy
CONFIG_VFIO_PCI_INTX=3Dy
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=3Dm
CONFIG_VFIO_MDEV_DEVICE=3Dm
CONFIG_IRQ_BYPASS_MANAGER=3Dm
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=3Dy
CONFIG_VIRTIO_MENU=3Dy
CONFIG_VIRTIO_PCI=3Dy
CONFIG_VIRTIO_PCI_LEGACY=3Dy
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=3Dm
CONFIG_VIRTIO_INPUT=3Dm
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=3Dm
CONFIG_HYPERV_TIMER=3Dy
CONFIG_HYPERV_UTILS=3Dm
CONFIG_HYPERV_BALLOON=3Dm
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=3Dy
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=3Dy
CONFIG_XEN_DEV_EVTCHN=3Dm
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=3Dm
CONFIG_XEN_COMPAT_XENFS=3Dy
CONFIG_XEN_SYS_HYPERVISOR=3Dy
CONFIG_XEN_XENBUS_FRONTEND=3Dy
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=3Dy
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=3Dm
CONFIG_XEN_EFI=3Dy
CONFIG_XEN_AUTO_XLATE=3Dy
CONFIG_XEN_ACPI=3Dy
# end of Xen driver support

# CONFIG_GREYBUS is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=3Dy
CONFIG_ACER_WMI=3Dm
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=3Dm
CONFIG_DCDBAS=3Dm
CONFIG_DELL_SMBIOS=3Dm
CONFIG_DELL_SMBIOS_WMI=3Dy
# CONFIG_DELL_SMBIOS_SMM is not set
CONFIG_DELL_LAPTOP=3Dm
CONFIG_DELL_WMI=3Dm
CONFIG_DELL_WMI_DESCRIPTOR=3Dm
CONFIG_DELL_WMI_AIO=3Dm
CONFIG_DELL_WMI_LED=3Dm
CONFIG_DELL_SMO8800=3Dm
CONFIG_DELL_RBTN=3Dm
CONFIG_DELL_RBU=3Dm
CONFIG_FUJITSU_LAPTOP=3Dm
CONFIG_FUJITSU_TABLET=3Dm
CONFIG_AMILO_RFKILL=3Dm
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=3Dm
CONFIG_HP_WIRELESS=3Dm
CONFIG_HP_WMI=3Dm
# CONFIG_LG_LAPTOP is not set
CONFIG_MSI_LAPTOP=3Dm
CONFIG_PANASONIC_LAPTOP=3Dm
CONFIG_COMPAL_LAPTOP=3Dm
CONFIG_SONY_LAPTOP=3Dm
CONFIG_SONYPI_COMPAT=3Dy
CONFIG_IDEAPAD_LAPTOP=3Dm
# CONFIG_SURFACE3_WMI is not set
CONFIG_THINKPAD_ACPI=3Dm
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=3Dy
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=3Dy
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=3Dy
CONFIG_SENSORS_HDAPS=3Dm
# CONFIG_INTEL_MENLOW is not set
CONFIG_EEEPC_LAPTOP=3Dm
CONFIG_ASUS_WMI=3Dm
CONFIG_ASUS_NB_WMI=3Dm
CONFIG_EEEPC_WMI=3Dm
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=3Dm
CONFIG_WMI_BMOF=3Dm
CONFIG_INTEL_WMI_THUNDERBOLT=3Dm
# CONFIG_XIAOMI_WMI is not set
CONFIG_MSI_WMI=3Dm
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=3Dm
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_TOSHIBA_BT_RFKILL=3Dm
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=3Dm
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_HID_EVENT=3Dm
CONFIG_INTEL_VBTN=3Dm
CONFIG_INTEL_IPS=3Dm
CONFIG_INTEL_PMC_CORE=3Dm
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=3Dm
CONFIG_MXM_WMI=3Dm
CONFIG_INTEL_OAKTRAIL=3Dm
CONFIG_SAMSUNG_Q10=3Dm
CONFIG_APPLE_GMUX=3Dm
CONFIG_INTEL_RST=3Dm
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_MLX_PLATFORM=3Dm
CONFIG_INTEL_TURBO_MAX_3=3Dy
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set

#
# Intel Speed Select Technology interface support
#
CONFIG_INTEL_SPEED_SELECT_INTERFACE=3Dm
# end of Intel Speed Select Technology interface support

CONFIG_PMC_ATOM=3Dy
# CONFIG_MFD_CROS_EC is not set
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=3Dy
CONFIG_MLXREG_HOTPLUG=3Dm
CONFIG_MLXREG_IO=3Dm
CONFIG_CLKDEV_LOOKUP=3Dy
CONFIG_HAVE_CLK_PREPARE=3Dy
CONFIG_COMMON_CLK=3Dy

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# end of Common Clock Framework

CONFIG_HWSPINLOCK=3Dy

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=3Dy
CONFIG_I8253_LOCK=3Dy
CONFIG_CLKBLD_I8253=3Dy
# end of Clock Source drivers

CONFIG_MAILBOX=3Dy
CONFIG_PCC=3Dy
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=3Dy
CONFIG_IOMMU_API=3Dy
CONFIG_IOMMU_SUPPORT=3Dy

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
CONFIG_IOMMU_DEFAULT_PASSTHROUGH=3Dy
CONFIG_AMD_IOMMU=3Dy
CONFIG_AMD_IOMMU_V2=3Dm
CONFIG_DMAR_TABLE=3Dy
CONFIG_INTEL_IOMMU=3Dy
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=3Dy
CONFIG_IRQ_REMAP=3Dy
CONFIG_HYPERV_IOMMU=3Dy

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=3Dm
CONFIG_IIO_BUFFER=3Dy
# CONFIG_IIO_BUFFER_CB is not set
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=3Dm
CONFIG_IIO_TRIGGERED_BUFFER=3Dm
# CONFIG_IIO_CONFIGFS is not set
CONFIG_IIO_TRIGGER=3Dy
CONFIG_IIO_CONSUMERS_PER_TRIGGER=3D2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL345_SPI is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=3Dm
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_SCA3000 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7124 is not set
# CONFIG_AD7266 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7766 is not set
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
# CONFIG_AD799X is not set
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
# CONFIG_MCP3911 is not set
# CONFIG_NAU7802 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_ADS7950 is not set
# CONFIG_TI_TLC4541 is not set
# CONFIG_VIPERBOARD_ADC is not set
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SPS30 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=3Dm
CONFIG_HID_SENSOR_IIO_TRIGGER=3Dm
# end of Hid Sensor IIO Common

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_LTC1660 is not set
# CONFIG_LTC2632 is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
# CONFIG_AD8801 is not set
# CONFIG_DS4424 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
# CONFIG_ADF4371 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=3Dm
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
CONFIG_HID_SENSOR_HUMIDITY=3Dm
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16460 is not set
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=3Dm
CONFIG_HID_SENSOR_PROX=3Dm
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=3Dm
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=3Dm
CONFIG_HID_SENSOR_DEVICE_ROTATION=3Dm
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5432 is not set
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
# CONFIG_DPS310 is not set
CONFIG_HID_SENSOR_PRESS=3Dm
# CONFIG_HP03 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_MAXIM_THERMOCOUPLE is not set
CONFIG_HID_SENSOR_TEMP=3Dm
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_MAX31856 is not set
# end of Temperature sensors

CONFIG_NTB=3Dm
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=3Dy
CONFIG_PWM_SYSFS=3Dy
CONFIG_PWM_LPSS=3Dm
CONFIG_PWM_LPSS_PCI=3Dm
CONFIG_PWM_LPSS_PLATFORM=3Dm
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# end of PHY Subsystem

CONFIG_POWERCAP=3Dy
CONFIG_INTEL_RAPL_CORE=3Dm
CONFIG_INTEL_RAPL=3Dm
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=3Dy
# CONFIG_RAS_CEC is not set
CONFIG_THUNDERBOLT=3Dy

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_LIBNVDIMM=3Dm
CONFIG_BLK_DEV_PMEM=3Dm
CONFIG_ND_BLK=3Dm
CONFIG_ND_CLAIM=3Dy
CONFIG_ND_BTT=3Dm
CONFIG_BTT=3Dy
CONFIG_ND_PFN=3Dm
CONFIG_NVDIMM_PFN=3Dy
CONFIG_NVDIMM_DAX=3Dy
CONFIG_NVDIMM_KEYS=3Dy
CONFIG_DAX_DRIVER=3Dy
CONFIG_DAX=3Dy
CONFIG_DEV_DAX=3Dm
CONFIG_DEV_DAX_PMEM=3Dm
CONFIG_DEV_DAX_KMEM=3Dm
CONFIG_DEV_DAX_PMEM_COMPAT=3Dm
CONFIG_NVMEM=3Dy
CONFIG_NVMEM_SYSFS=3Dy

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=3Dy
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=3Dy
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=3Dm
CONFIG_EXT4_USE_FOR_EXT2=3Dy
CONFIG_EXT4_FS_POSIX_ACL=3Dy
CONFIG_EXT4_FS_SECURITY=3Dy
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=3Dm
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=3Dm
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=3Dm
CONFIG_XFS_QUOTA=3Dy
CONFIG_XFS_POSIX_ACL=3Dy
# CONFIG_XFS_RT is not set
CONFIG_XFS_ONLINE_SCRUB=3Dy
# CONFIG_XFS_ONLINE_REPAIR is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=3Dm
CONFIG_GFS2_FS_LOCKING_DLM=3Dy
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
CONFIG_FS_DAX=3Dy
CONFIG_FS_DAX_PMD=3Dy
CONFIG_FS_POSIX_ACL=3Dy
CONFIG_EXPORTFS=3Dy
CONFIG_EXPORTFS_BLOCK_OPS=3Dy
CONFIG_FILE_LOCKING=3Dy
# CONFIG_MANDATORY_FILE_LOCKING is not set
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=3Dy
CONFIG_DNOTIFY=3Dy
CONFIG_INOTIFY_USER=3Dy
CONFIG_FANOTIFY=3Dy
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=3Dy
CONFIG_QUOTA=3Dy
CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
CONFIG_PRINT_QUOTA_WARNING=3Dy
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=3Dy
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=3Dy
CONFIG_QUOTACTL=3Dy
CONFIG_QUOTACTL_COMPAT=3Dy
CONFIG_AUTOFS4_FS=3Dy
CONFIG_AUTOFS_FS=3Dy
CONFIG_FUSE_FS=3Dm
CONFIG_CUSE=3Dm
CONFIG_VIRTIO_FS=3Dm
CONFIG_OVERLAY_FS=3Dm
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=3Dm
CONFIG_FSCACHE_STATS=3Dy
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=3Dm
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_UDF_FS=3Dm
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dm
CONFIG_FAT_DEFAULT_CODEPAGE=3D437
CONFIG_FAT_DEFAULT_IOCHARSET=3D"ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_PROC_VMCORE=3Dy
CONFIG_PROC_VMCORE_DEVICE_DUMP=3Dy
CONFIG_PROC_SYSCTL=3Dy
CONFIG_PROC_PAGE_MONITOR=3Dy
CONFIG_PROC_CHILDREN=3Dy
CONFIG_PROC_PID_ARCH_STATUS=3Dy
CONFIG_KERNFS=3Dy
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
CONFIG_TMPFS_POSIX_ACL=3Dy
CONFIG_TMPFS_XATTR=3Dy
CONFIG_HUGETLBFS=3Dy
CONFIG_HUGETLB_PAGE=3Dy
CONFIG_MEMFD_CREATE=3Dy
CONFIG_ARCH_HAS_GIGANTIC_PAGE=3Dy
CONFIG_CONFIGFS_FS=3Dy
CONFIG_EFIVAR_FS=3Dy
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=3Dy
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=3Dm
CONFIG_CRAMFS_BLOCKDEV=3Dy
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=3Dm
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=3Dy
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=3Dy
CONFIG_SQUASHFS_XATTR=3Dy
CONFIG_SQUASHFS_ZLIB=3Dy
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=3Dy
CONFIG_SQUASHFS_XZ=3Dy
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3D3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=3Dy
CONFIG_PSTORE_DEFLATE_COMPRESS=3Dy
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=3Dy
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=3Dy
CONFIG_PSTORE_COMPRESS_DEFAULT=3D"deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=3Dm
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=3Dy
CONFIG_NFS_FS=3Dm
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=3Dm
CONFIG_NFS_V3_ACL=3Dy
CONFIG_NFS_V4=3Dm
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=3Dy
CONFIG_NFS_V4_2=3Dy
CONFIG_PNFS_FILE_LAYOUT=3Dm
CONFIG_PNFS_BLOCK=3Dm
CONFIG_PNFS_FLEXFILE_LAYOUT=3Dm
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN=3D"kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=3Dy
CONFIG_NFS_FSCACHE=3Dy
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=3Dy
CONFIG_NFS_DEBUG=3Dy
CONFIG_NFSD=3Dm
CONFIG_NFSD_V2_ACL=3Dy
CONFIG_NFSD_V3=3Dy
CONFIG_NFSD_V3_ACL=3Dy
CONFIG_NFSD_V4=3Dy
CONFIG_NFSD_PNFS=3Dy
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=3Dy
# CONFIG_NFSD_FLEXFILELAYOUT is not set
CONFIG_NFSD_V4_SECURITY_LABEL=3Dy
CONFIG_GRACE_PERIOD=3Dm
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy
CONFIG_NFS_ACL_SUPPORT=3Dm
CONFIG_NFS_COMMON=3Dy
CONFIG_SUNRPC=3Dm
CONFIG_SUNRPC_GSS=3Dm
CONFIG_SUNRPC_BACKCHANNEL=3Dy
CONFIG_RPCSEC_GSS_KRB5=3Dm
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=3Dy
CONFIG_SUNRPC_XPRT_RDMA=3Dm
CONFIG_CEPH_FS=3Dm
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=3Dy
CONFIG_CEPH_FS_SECURITY_LABEL=3Dy
CONFIG_CIFS=3Dm
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=3Dy
CONFIG_CIFS_WEAK_PW_HASH=3Dy
CONFIG_CIFS_UPCALL=3Dy
CONFIG_CIFS_XATTR=3Dy
CONFIG_CIFS_POSIX=3Dy
CONFIG_CIFS_DEBUG=3Dy
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=3Dy
# CONFIG_CIFS_SMB_DIRECT is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"utf8"
CONFIG_NLS_CODEPAGE_437=3Dy
CONFIG_NLS_CODEPAGE_737=3Dm
CONFIG_NLS_CODEPAGE_775=3Dm
CONFIG_NLS_CODEPAGE_850=3Dm
CONFIG_NLS_CODEPAGE_852=3Dm
CONFIG_NLS_CODEPAGE_855=3Dm
CONFIG_NLS_CODEPAGE_857=3Dm
CONFIG_NLS_CODEPAGE_860=3Dm
CONFIG_NLS_CODEPAGE_861=3Dm
CONFIG_NLS_CODEPAGE_862=3Dm
CONFIG_NLS_CODEPAGE_863=3Dm
CONFIG_NLS_CODEPAGE_864=3Dm
CONFIG_NLS_CODEPAGE_865=3Dm
CONFIG_NLS_CODEPAGE_866=3Dm
CONFIG_NLS_CODEPAGE_869=3Dm
CONFIG_NLS_CODEPAGE_936=3Dm
CONFIG_NLS_CODEPAGE_950=3Dm
CONFIG_NLS_CODEPAGE_932=3Dm
CONFIG_NLS_CODEPAGE_949=3Dm
CONFIG_NLS_CODEPAGE_874=3Dm
CONFIG_NLS_ISO8859_8=3Dm
CONFIG_NLS_CODEPAGE_1250=3Dm
CONFIG_NLS_CODEPAGE_1251=3Dm
CONFIG_NLS_ASCII=3Dy
CONFIG_NLS_ISO8859_1=3Dm
CONFIG_NLS_ISO8859_2=3Dm
CONFIG_NLS_ISO8859_3=3Dm
CONFIG_NLS_ISO8859_4=3Dm
CONFIG_NLS_ISO8859_5=3Dm
CONFIG_NLS_ISO8859_6=3Dm
CONFIG_NLS_ISO8859_7=3Dm
CONFIG_NLS_ISO8859_9=3Dm
CONFIG_NLS_ISO8859_13=3Dm
CONFIG_NLS_ISO8859_14=3Dm
CONFIG_NLS_ISO8859_15=3Dm
CONFIG_NLS_KOI8_R=3Dm
CONFIG_NLS_KOI8_U=3Dm
CONFIG_NLS_MAC_ROMAN=3Dm
CONFIG_NLS_MAC_CELTIC=3Dm
CONFIG_NLS_MAC_CENTEURO=3Dm
CONFIG_NLS_MAC_CROATIAN=3Dm
CONFIG_NLS_MAC_CYRILLIC=3Dm
CONFIG_NLS_MAC_GAELIC=3Dm
CONFIG_NLS_MAC_GREEK=3Dm
CONFIG_NLS_MAC_ICELAND=3Dm
CONFIG_NLS_MAC_INUIT=3Dm
CONFIG_NLS_MAC_ROMANIAN=3Dm
CONFIG_NLS_MAC_TURKISH=3Dm
CONFIG_NLS_UTF8=3Dm
CONFIG_DLM=3Dm
CONFIG_DLM_DEBUG=3Dy
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=3Dy
CONFIG_KEYS_COMPAT=3Dy
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=3Dy
CONFIG_BIG_KEYS=3Dy
CONFIG_TRUSTED_KEYS=3Dy
CONFIG_ENCRYPTED_KEYS=3Dy
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=3Dy
CONFIG_SECURITY_WRITABLE_HOOKS=3Dy
CONFIG_SECURITYFS=3Dy
CONFIG_SECURITY_NETWORK=3Dy
CONFIG_PAGE_TABLE_ISOLATION=3Dy
CONFIG_SECURITY_INFINIBAND=3Dy
CONFIG_SECURITY_NETWORK_XFRM=3Dy
# CONFIG_SECURITY_PATH is not set
CONFIG_INTEL_TXT=3Dy
CONFIG_LSM_MMAP_MIN_ADDR=3D65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=3Dy
CONFIG_HARDENED_USERCOPY=3Dy
CONFIG_HARDENED_USERCOPY_FALLBACK=3Dy
CONFIG_FORTIFY_SOURCE=3Dy
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=3Dy
CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy
CONFIG_SECURITY_SELINUX_DISABLE=3Dy
CONFIG_SECURITY_SELINUX_DEVELOP=3Dy
CONFIG_SECURITY_SELINUX_AVC_STATS=3Dy
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=3D1
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=3Dy
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=3Dy
CONFIG_INTEGRITY_SIGNATURE=3Dy
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=3Dy
CONFIG_INTEGRITY_TRUSTED_KEYRING=3Dy
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=3Dy
CONFIG_IMA=3Dy
CONFIG_IMA_MEASURE_PCR_IDX=3D10
CONFIG_IMA_LSM_RULES=3Dy
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=3Dy
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE=3D"ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=3Dy
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
CONFIG_IMA_DEFAULT_HASH=3D"sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=3Dy
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=3Dy
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=3Dy
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_EVM=3Dy
CONFIG_EVM_ATTR_FSUUID=3Dy
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=3Dy
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM=3D"yama,integrity,selinux"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=3Dy
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=3Dm
CONFIG_ASYNC_CORE=3Dm
CONFIG_ASYNC_MEMCPY=3Dm
CONFIG_ASYNC_XOR=3Dm
CONFIG_ASYNC_PQ=3Dm
CONFIG_ASYNC_RAID6_RECOV=3Dm
CONFIG_CRYPTO=3Dy

#
# Crypto core or helper
#
CONFIG_CRYPTO_FIPS=3Dy
CONFIG_CRYPTO_ALGAPI=3Dy
CONFIG_CRYPTO_ALGAPI2=3Dy
CONFIG_CRYPTO_AEAD=3Dy
CONFIG_CRYPTO_AEAD2=3Dy
CONFIG_CRYPTO_BLKCIPHER=3Dy
CONFIG_CRYPTO_BLKCIPHER2=3Dy
CONFIG_CRYPTO_HASH=3Dy
CONFIG_CRYPTO_HASH2=3Dy
CONFIG_CRYPTO_RNG=3Dy
CONFIG_CRYPTO_RNG2=3Dy
CONFIG_CRYPTO_RNG_DEFAULT=3Dy
CONFIG_CRYPTO_AKCIPHER2=3Dy
CONFIG_CRYPTO_AKCIPHER=3Dy
CONFIG_CRYPTO_KPP2=3Dy
CONFIG_CRYPTO_KPP=3Dm
CONFIG_CRYPTO_ACOMP2=3Dy
CONFIG_CRYPTO_MANAGER=3Dy
CONFIG_CRYPTO_MANAGER2=3Dy
CONFIG_CRYPTO_USER=3Dm
# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
# CONFIG_CRYPTO_MANAGER_EXTRA_TESTS is not set
CONFIG_CRYPTO_GF128MUL=3Dy
CONFIG_CRYPTO_NULL=3Dy
CONFIG_CRYPTO_NULL2=3Dy
CONFIG_CRYPTO_PCRYPT=3Dm
CONFIG_CRYPTO_CRYPTD=3Dy
CONFIG_CRYPTO_AUTHENC=3Dm
CONFIG_CRYPTO_TEST=3Dm
CONFIG_CRYPTO_SIMD=3Dy
CONFIG_CRYPTO_GLUE_HELPER_X86=3Dy

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=3Dy
CONFIG_CRYPTO_DH=3Dm
CONFIG_CRYPTO_ECC=3Dm
CONFIG_CRYPTO_ECDH=3Dm
# CONFIG_CRYPTO_ECRDSA is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=3Dm
CONFIG_CRYPTO_GCM=3Dy
CONFIG_CRYPTO_CHACHA20POLY1305=3Dm
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=3Dy
CONFIG_CRYPTO_ECHAINIV=3Dm

#
# Block modes
#
CONFIG_CRYPTO_CBC=3Dy
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=3Dy
CONFIG_CRYPTO_CTS=3Dm
CONFIG_CRYPTO_ECB=3Dy
CONFIG_CRYPTO_LRW=3Dm
CONFIG_CRYPTO_OFB=3Dm
CONFIG_CRYPTO_PCBC=3Dm
CONFIG_CRYPTO_XTS=3Dm
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_NHPOLY1305=3Dm
CONFIG_CRYPTO_NHPOLY1305_SSE2=3Dm
CONFIG_CRYPTO_NHPOLY1305_AVX2=3Dm
CONFIG_CRYPTO_ADIANTUM=3Dm
CONFIG_CRYPTO_ESSIV=3Dm

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=3Dm
CONFIG_CRYPTO_HMAC=3Dy
CONFIG_CRYPTO_XCBC=3Dm
CONFIG_CRYPTO_VMAC=3Dm

#
# Digest
#
CONFIG_CRYPTO_CRC32C=3Dy
CONFIG_CRYPTO_CRC32C_INTEL=3Dm
CONFIG_CRYPTO_CRC32=3Dm
CONFIG_CRYPTO_CRC32_PCLMUL=3Dm
CONFIG_CRYPTO_XXHASH=3Dm
CONFIG_CRYPTO_CRCT10DIF=3Dy
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=3Dm
CONFIG_CRYPTO_GHASH=3Dy
CONFIG_CRYPTO_POLY1305=3Dm
CONFIG_CRYPTO_POLY1305_X86_64=3Dm
CONFIG_CRYPTO_MD4=3Dm
CONFIG_CRYPTO_MD5=3Dy
CONFIG_CRYPTO_MICHAEL_MIC=3Dm
CONFIG_CRYPTO_RMD128=3Dm
CONFIG_CRYPTO_RMD160=3Dm
CONFIG_CRYPTO_RMD256=3Dm
CONFIG_CRYPTO_RMD320=3Dm
CONFIG_CRYPTO_SHA1=3Dy
CONFIG_CRYPTO_SHA1_SSSE3=3Dy
CONFIG_CRYPTO_SHA256_SSSE3=3Dy
CONFIG_CRYPTO_SHA512_SSSE3=3Dm
CONFIG_CRYPTO_LIB_SHA256=3Dy
CONFIG_CRYPTO_SHA256=3Dy
CONFIG_CRYPTO_SHA512=3Dm
CONFIG_CRYPTO_SHA3=3Dm
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=3Dm
CONFIG_CRYPTO_WP512=3Dm
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=3Dm

#
# Ciphers
#
CONFIG_CRYPTO_LIB_AES=3Dy
CONFIG_CRYPTO_AES=3Dy
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=3Dy
CONFIG_CRYPTO_ANUBIS=3Dm
CONFIG_CRYPTO_LIB_ARC4=3Dm
CONFIG_CRYPTO_ARC4=3Dm
CONFIG_CRYPTO_BLOWFISH=3Dm
CONFIG_CRYPTO_BLOWFISH_COMMON=3Dm
CONFIG_CRYPTO_BLOWFISH_X86_64=3Dm
CONFIG_CRYPTO_CAMELLIA=3Dm
CONFIG_CRYPTO_CAMELLIA_X86_64=3Dm
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=3Dm
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=3Dm
CONFIG_CRYPTO_CAST_COMMON=3Dm
CONFIG_CRYPTO_CAST5=3Dm
CONFIG_CRYPTO_CAST5_AVX_X86_64=3Dm
CONFIG_CRYPTO_CAST6=3Dm
CONFIG_CRYPTO_CAST6_AVX_X86_64=3Dm
CONFIG_CRYPTO_LIB_DES=3Dm
CONFIG_CRYPTO_DES=3Dm
CONFIG_CRYPTO_DES3_EDE_X86_64=3Dm
CONFIG_CRYPTO_FCRYPT=3Dm
CONFIG_CRYPTO_KHAZAD=3Dm
CONFIG_CRYPTO_SALSA20=3Dm
CONFIG_CRYPTO_CHACHA20=3Dm
CONFIG_CRYPTO_CHACHA20_X86_64=3Dm
CONFIG_CRYPTO_SEED=3Dm
CONFIG_CRYPTO_SERPENT=3Dm
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=3Dm
CONFIG_CRYPTO_SERPENT_AVX_X86_64=3Dm
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=3Dm
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=3Dm
CONFIG_CRYPTO_TWOFISH=3Dm
CONFIG_CRYPTO_TWOFISH_COMMON=3Dm
CONFIG_CRYPTO_TWOFISH_X86_64=3Dm
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=3Dm
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=3Dm

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=3Dy
CONFIG_CRYPTO_LZO=3Dy
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=3Dm
CONFIG_CRYPTO_DRBG_MENU=3Dy
CONFIG_CRYPTO_DRBG_HMAC=3Dy
CONFIG_CRYPTO_DRBG_HASH=3Dy
CONFIG_CRYPTO_DRBG_CTR=3Dy
CONFIG_CRYPTO_DRBG=3Dy
CONFIG_CRYPTO_JITTERENTROPY=3Dy
CONFIG_CRYPTO_USER_API=3Dy
CONFIG_CRYPTO_USER_API_HASH=3Dy
CONFIG_CRYPTO_USER_API_SKCIPHER=3Dy
CONFIG_CRYPTO_USER_API_RNG=3Dy
CONFIG_CRYPTO_USER_API_AEAD=3Dy
CONFIG_CRYPTO_STATS=3Dy
CONFIG_CRYPTO_HASH_INFO=3Dy
CONFIG_CRYPTO_HW=3Dy
CONFIG_CRYPTO_DEV_PADLOCK=3Dm
CONFIG_CRYPTO_DEV_PADLOCK_AES=3Dm
CONFIG_CRYPTO_DEV_PADLOCK_SHA=3Dm
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=3Dy
CONFIG_CRYPTO_DEV_CCP_DD=3Dm
CONFIG_CRYPTO_DEV_SP_CCP=3Dy
CONFIG_CRYPTO_DEV_CCP_CRYPTO=3Dm
CONFIG_CRYPTO_DEV_SP_PSP=3Dy
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=3Dm
CONFIG_CRYPTO_DEV_QAT_DH895xCC=3Dm
CONFIG_CRYPTO_DEV_QAT_C3XXX=3Dm
CONFIG_CRYPTO_DEV_QAT_C62X=3Dm
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=3Dm
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=3Dm
CONFIG_CRYPTO_DEV_QAT_C62XVF=3Dm
CONFIG_CRYPTO_DEV_NITROX=3Dm
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=3Dm
CONFIG_CRYPTO_DEV_CHELSIO=3Dm
CONFIG_CHELSIO_IPSEC_INLINE=3Dy
# CONFIG_CRYPTO_DEV_CHELSIO_TLS is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=3Dy
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=3Dy
CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE=3Dm
CONFIG_X509_CERTIFICATE_PARSER=3Dy
CONFIG_PKCS8_PRIVATE_KEY_PARSER=3Dm
# CONFIG_TPM_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=3Dy
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=3Dy

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY=3D"certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=3Dy
CONFIG_SYSTEM_TRUSTED_KEYS=3D""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=3Dy
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=3D""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=3Dy

#
# Library routines
#
CONFIG_RAID6_PQ=3Dm
# CONFIG_RAID6_PQ_BENCHMARK is not set
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=3Dy
CONFIG_GENERIC_STRNCPY_FROM_USER=3Dy
CONFIG_GENERIC_STRNLEN_USER=3Dy
CONFIG_GENERIC_NET_UTILS=3Dy
CONFIG_GENERIC_FIND_FIRST_BIT=3Dy
CONFIG_CORDIC=3Dm
CONFIG_RATIONAL=3Dy
CONFIG_GENERIC_PCI_IOMAP=3Dy
CONFIG_GENERIC_IOMAP=3Dy
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=3Dy
CONFIG_ARCH_HAS_FAST_MULTIPLIER=3Dy
CONFIG_CRC_CCITT=3Dy
CONFIG_CRC16=3Dy
CONFIG_CRC_T10DIF=3Dy
CONFIG_CRC_ITU_T=3Dm
CONFIG_CRC32=3Dy
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=3Dy
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=3Dm
CONFIG_LIBCRC32C=3Dm
CONFIG_CRC8=3Dm
CONFIG_XXHASH=3Dy
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dy
CONFIG_LZO_COMPRESS=3Dy
CONFIG_LZO_DECOMPRESS=3Dy
CONFIG_LZ4_DECOMPRESS=3Dy
CONFIG_XZ_DEC=3Dy
CONFIG_XZ_DEC_X86=3Dy
CONFIG_XZ_DEC_POWERPC=3Dy
CONFIG_XZ_DEC_IA64=3Dy
CONFIG_XZ_DEC_ARM=3Dy
CONFIG_XZ_DEC_ARMTHUMB=3Dy
CONFIG_XZ_DEC_SPARC=3Dy
CONFIG_XZ_DEC_BCJ=3Dy
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=3Dy
CONFIG_DECOMPRESS_BZIP2=3Dy
CONFIG_DECOMPRESS_LZMA=3Dy
CONFIG_DECOMPRESS_XZ=3Dy
CONFIG_DECOMPRESS_LZO=3Dy
CONFIG_DECOMPRESS_LZ4=3Dy
CONFIG_GENERIC_ALLOCATOR=3Dy
CONFIG_REED_SOLOMON=3Dm
CONFIG_REED_SOLOMON_ENC8=3Dy
CONFIG_REED_SOLOMON_DEC8=3Dy
CONFIG_TEXTSEARCH=3Dy
CONFIG_TEXTSEARCH_KMP=3Dm
CONFIG_TEXTSEARCH_BM=3Dm
CONFIG_TEXTSEARCH_FSM=3Dm
CONFIG_BTREE=3Dy
CONFIG_INTERVAL_TREE=3Dy
CONFIG_XARRAY_MULTI=3Dy
CONFIG_ASSOCIATIVE_ARRAY=3Dy
CONFIG_HAS_IOMEM=3Dy
CONFIG_HAS_IOPORT_MAP=3Dy
CONFIG_HAS_DMA=3Dy
CONFIG_NEED_SG_DMA_LENGTH=3Dy
CONFIG_NEED_DMA_MAP_STATE=3Dy
CONFIG_ARCH_DMA_ADDR_T_64BIT=3Dy
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=3Dy
CONFIG_DMA_VIRT_OPS=3Dy
CONFIG_SWIOTLB=3Dy
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=3Dy
CONFIG_CHECK_SIGNATURE=3Dy
CONFIG_CPUMASK_OFFSTACK=3Dy
CONFIG_CPU_RMAP=3Dy
CONFIG_DQL=3Dy
CONFIG_GLOB=3Dy
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=3Dy
CONFIG_CLZ_TAB=3Dy
CONFIG_IRQ_POLL=3Dy
CONFIG_MPILIB=3Dy
CONFIG_SIGNATURE=3Dy
CONFIG_DIMLIB=3Dy
CONFIG_OID_REGISTRY=3Dy
CONFIG_UCS2_STRING=3Dy
CONFIG_HAVE_GENERIC_VDSO=3Dy
CONFIG_GENERIC_GETTIMEOFDAY=3Dy
CONFIG_FONT_SUPPORT=3Dy
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy
CONFIG_SG_POOL=3Dy
CONFIG_ARCH_HAS_PMEM_API=3Dy
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=3Dy
CONFIG_ARCH_HAS_UACCESS_MCSAFE=3Dy
CONFIG_ARCH_STACKWALK=3Dy
CONFIG_SBITMAP=3Dy
CONFIG_PARMAN=3Dm
CONFIG_OBJAGG=3Dm
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=3Dy
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=3D7
CONFIG_CONSOLE_LOGLEVEL_QUIET=3D4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=3D4
CONFIG_BOOT_PRINTK_DELAY=3Dy
CONFIG_DYNAMIC_DEBUG=3Dy
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=3Dy
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_DWARF4=3Dy
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=3Dy
CONFIG_FRAME_WARN=3D2048
CONFIG_STRIP_ASM_SYMS=3Dy
# CONFIG_READABLE_ASM is not set
CONFIG_DEBUG_FS=3Dy
CONFIG_HEADERS_INSTALL=3Dy
CONFIG_HEADERS_CHECK=3Dy
CONFIG_OPTIMIZE_INLINING=3Dy
CONFIG_DEBUG_SECTION_MISMATCH=3Dy
CONFIG_SECTION_MISMATCH_WARN_ONLY=3Dy
CONFIG_STACK_VALIDATION=3Dy
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=3D0x1
CONFIG_MAGIC_SYSRQ_SERIAL=3Dy
CONFIG_DEBUG_KERNEL=3Dy
CONFIG_DEBUG_MISC=3Dy

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=3Dy
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=3Dy
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=3Dy
CONFIG_CC_HAS_KASAN_GENERIC=3Dy
# CONFIG_KASAN is not set
CONFIG_KASAN_STACK=3D1
# end of Memory Debugging

CONFIG_ARCH_HAS_KCOV=3Dy
CONFIG_CC_HAS_SANCOV_TRACE_PC=3Dy
# CONFIG_KCOV is not set
CONFIG_DEBUG_SHIRQ=3Dy

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=3Dy
CONFIG_SOFTLOCKUP_DETECTOR=3Dy
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D0
CONFIG_HARDLOCKUP_DETECTOR_PERF=3Dy
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=3Dy
CONFIG_HARDLOCKUP_DETECTOR=3Dy
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=3Dy
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=3D1
CONFIG_DETECT_HUNG_TASK=3Dy
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=3D0
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Lockups and Hangs

CONFIG_PANIC_ON_OOPS=3Dy
CONFIG_PANIC_ON_OOPS_VALUE=3D1
CONFIG_PANIC_TIMEOUT=3D0
CONFIG_SCHED_DEBUG=3Dy
CONFIG_SCHED_INFO=3Dy
CONFIG_SCHEDSTATS=3Dy
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=3Dy
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=3Dy
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=3Dy
CONFIG_DEBUG_LIST=3Dy
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=3D60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=3Dy
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=3Dy
CONFIG_NOP_TRACER=3Dy
CONFIG_HAVE_FUNCTION_TRACER=3Dy
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=3Dy
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
CONFIG_HAVE_FENTRY=3Dy
CONFIG_HAVE_C_RECORDMCOUNT=3Dy
CONFIG_TRACER_MAX_TRACE=3Dy
CONFIG_TRACE_CLOCK=3Dy
CONFIG_RING_BUFFER=3Dy
CONFIG_EVENT_TRACING=3Dy
CONFIG_CONTEXT_SWITCH_TRACER=3Dy
CONFIG_RING_BUFFER_ALLOW_SWAP=3Dy
CONFIG_TRACING=3Dy
CONFIG_GENERIC_TRACER=3Dy
CONFIG_TRACING_SUPPORT=3Dy
CONFIG_FTRACE=3Dy
CONFIG_FUNCTION_TRACER=3Dy
CONFIG_FUNCTION_GRAPH_TRACER=3Dy
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=3Dy
CONFIG_HWLAT_TRACER=3Dy
CONFIG_FTRACE_SYSCALLS=3Dy
CONFIG_TRACER_SNAPSHOT=3Dy
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=3Dy
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_STACK_TRACER=3Dy
CONFIG_BLK_DEV_IO_TRACE=3Dy
CONFIG_KPROBE_EVENTS=3Dy
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=3Dy
CONFIG_BPF_EVENTS=3Dy
CONFIG_DYNAMIC_EVENTS=3Dy
CONFIG_PROBE_EVENTS=3Dy
CONFIG_DYNAMIC_FTRACE=3Dy
CONFIG_DYNAMIC_FTRACE_WITH_REGS=3Dy
CONFIG_FUNCTION_PROFILER=3Dy
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=3Dy
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=3Dy
CONFIG_HIST_TRIGGERS=3Dy
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=3Dm
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=3Dy
CONFIG_RUNTIME_TESTING_MENU=3Dy
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=3Dy
CONFIG_ASYNC_RAID6_TEST=3Dm
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
CONFIG_TEST_KSTRTOX=3Dy
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_PARMAN is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=3Dm
# CONFIG_TEST_OBJAGG is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=3Dy
CONFIG_KGDB=3Dy
CONFIG_KGDB_SERIAL_CONSOLE=3Dy
CONFIG_KGDB_TESTS=3Dy
# CONFIG_KGDB_TESTS_ON_BOOT is not set
CONFIG_KGDB_LOW_LEVEL_TRAP=3Dy
CONFIG_KGDB_KDB=3Dy
CONFIG_KDB_DEFAULT_ENABLE=3D0x0
CONFIG_KDB_KEYBOARD=3Dy
CONFIG_KDB_CONTINUE_CATASTROPHIC=3D0
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=3Dy
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=3Dy
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=3Dy
CONFIG_STRICT_DEVMEM=3Dy
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
CONFIG_EARLY_PRINTK_USB=3Dy
# CONFIG_X86_VERBOSE_BOOTUP is not set
CONFIG_EARLY_PRINTK=3Dy
CONFIG_EARLY_PRINTK_DBGP=3Dy
CONFIG_EARLY_PRINTK_USB_XDBC=3Dy
CONFIG_X86_PTDUMP_CORE=3Dy
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
CONFIG_DEBUG_WX=3Dy
CONFIG_DOUBLEFAULT=3Dy
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=3Dy
CONFIG_X86_DECODER_SELFTEST=3Dy
CONFIG_IO_DELAY_0X80=3Dy
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=3Dy
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=3Dy
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of Kernel hacking

#
# Red Hat options
#
CONFIG_RH_DISABLE_DEPRECATED=3Dy
# end of Red Hat options

--omz5tebd6o7fekfs
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--omz5tebd6o7fekfs--

