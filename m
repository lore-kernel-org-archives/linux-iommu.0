Return-Path: <SRS0=U/E5=CJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AFCC433E6
	for <iommu@archiver.kernel.org>; Mon, 31 Aug 2020 11:10:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E41DA2072D
	for <iommu@archiver.kernel.org>; Mon, 31 Aug 2020 11:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41DA2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AD68785BD0;
	Mon, 31 Aug 2020 11:10:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PYXtPqt-aEmQ; Mon, 31 Aug 2020 11:10:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 36179845AA;
	Mon, 31 Aug 2020 11:10:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 181E2C07FF;
	Mon, 31 Aug 2020 11:10:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD78CC0051
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 11:09:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CEE7385629
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 11:09:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m6uwxvm4yliy for <iommu@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 11:09:15 +0000 (UTC)
X-Greylist: delayed 00:05:46 by SQLgrey-1.7.6
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B23E8836F1
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 11:09:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by a.mx.secunet.com (Postfix) with ESMTP id E26F9205ED;
 Mon, 31 Aug 2020 13:03:24 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
 by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BVAiCQjrqVi7; Mon, 31 Aug 2020 13:03:21 +0200 (CEST)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de
 [10.53.40.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by a.mx.secunet.com (Postfix) with ESMTPS id 422B820491;
 Mon, 31 Aug 2020 13:03:21 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 mail-essen-01.secunet.de (10.53.40.204) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Mon, 31 Aug 2020 13:03:21 +0200
Received: from [172.18.16.185] (172.18.16.185) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 31 Aug
 2020 13:03:20 +0200
To: Joerg Roedel <jroedel@suse.de>
From: Torsten Hilbrich <torsten.hilbrich@secunet.com>
Autocrypt: addr=torsten.hilbrich@secunet.com; prefer-encrypt=mutual; keydata=
 mQENBFs5uIIBCAD4qbEieyT7sBmcro1VrCE1sSnV29a9ub8c0Xj0yw0Cz2N7LalBn4a+YeJN
 OMfL1MQvEiTxZNIzb1I0bRYcfhkhjN4+vAoPJ3q1OpSY+WUgphUbzseUk/Bq3gwvfa6/U+Hm
 o2lvEfN2dewBGptQ+DrWz+SPM1TQiwShKjowY/avaVgrABBGen3LgB0XZXEH8Q720kjP7htK
 tCGRt1T+qNIj3tZDZfPkqEVb8lTRcyn1hI3/FbDTysletRrCmkHSVbnxNzO6lw2G1H61wQhw
 YVbIVNohY61ieSJFhNLL6/UTGHtUE2IAicnsUAUKR8GiI1+3cTf233O5HaWYeOjBmTCLABEB
 AAG0L1RvcnN0ZW4gSGlsYnJpY2ggPHRvcnN0ZW4uaGlsYnJpY2hAc2VjdW5ldC5jb20+iQE3
 BBMBCAAhBQJbObiCAhsDBQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEJ7rXZh78/h8+tIH
 +QFYRQH4qh3WagcmjbG/zCe2RmZZePO8bmut2fAxY04aqJZGYUBxb5lfaWaHkstqM5sFD8Jo
 k1j5E7f1cnfwB21azdUO8fzYL889kdVOzatdT/uTjR7OjR59gpJMd4lx7fwFuZUg8z6rfWJ3
 ImjxxBgaJRL6pqaZ9lOst82O0qJKEFBR+HDUVvgh4n8TTOfKNv/dGPQhaed+2or98asdYRWo
 S/zc4ltTh4SxZjLd98pDxjlUyOJoMJeWdlMmLgWV3h1qjy4DxgQzvgATEaKjOuwtkCOcwHn7
 Unf0F2V9p4O7NFOuoVyqTBRX+5xKgzSM7VP1RlTT4FA9/7wkhhG+FEK5AQ0EWzm4ggEIAL9F
 IIPQYMx5x+zMjm8lDsmh12zoqCtMfn9QWrERd2gDS3GsORbe/i6DhYvzsulH8vsviPle4ocU
 +PaTwadfnEqm0FS7xCONYookDGfAiPS4cHWX7WrTNBP7mK3Gl1KaAOJJsMbCVAA9q4d8WL+A
 e+XrfOAetZq5gxLxDMYySNI1pIMJVrGECiboLa/LPPh2yw4jieAedW96CPuZs7rUY/5uIVt0
 Dn4/aSzV+Ixr52Z2McvNmH/VxDt59Z6jBztZIJBXpX3BC/UyH7rJOJTaqEF+EVWEpOmSoZ6u
 i1DWyqOBKnQrbUa0fpNd3aaOl2KnlgTH9upm70XZGpeJik/pQGcAEQEAAYkBHwQYAQgACQUC
 Wzm4ggIbDAAKCRCe612Ye/P4fEzqB/9gcM/bODO8o9YR86BLp0S8bF73lwIJyDHg5brjqAnz
 CtCdb4I+evI4iyU9zuN1x4V+Te5ej+mUu5CbIte8gQbo4cc9sbe/AEDoOh0lGoXKZiwtHqoh
 RZ4jOFrZJsEjOSUCLE8E8VR1afPf0SkFXLXWZfZDU28K80JWeV1BCtxutZ39bz6ybMbcCvMS
 UfwCTY0IJOiDga1K4H2HzHAqlvfzCurqe616S4S1ax+erg3KTEXylxmzcFjJU8AUZURy/lQt
 VElzs4Km1p3v6GUciCAb+Uhd12sQG2mL05jmEems9uRe3Wfke/RKp8A+Yq+p6E0A0ZOP+Okm
 LXB2q+ckPvZG
Subject: [Regression] [PATCH] iommu: Avoid crash in init_no_remapping_devices
 if iommu is NULL
Message-ID: <e27cd096-a721-db9d-e4ce-7a432ed6cd4c@secunet.com>
Date: Mon, 31 Aug 2020 13:03:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------C3F9CFC4B3CABC675A65CB7D"
Content-Language: en-US
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Mailman-Approved-At: Mon, 31 Aug 2020 11:10:17 +0000
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--------------C3F9CFC4B3CABC675A65CB7D
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

I noticed a kernel crash when trying to boot a v5.9-rc2 based kernel.

The crash reads as:

<1>[    7.410192] BUG: kernel NULL pointer dereference, address: 0000000000000038
<1>[    7.410196] #PF: supervisor write access in kernel mode
<1>[    7.410199] #PF: error_code(0x0002) - not-present page
<6>[    7.410202] PGD 0 P4D 0 
<4>[    7.410207] Oops: 0002 [#1] SMP PTI
<4>[    7.410212] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.9.0-devel+ #1
<4>[    7.410215] Hardware name: LENOVO 20HGS0TW00/20HGS0TW00, BIOS N1WET46S (1.25s ) 03/30/2018
<4>[    7.410224] RIP: 0010:intel_iommu_init+0xed0/0x1136
<4>[    7.410229] Code: fe e9 61 02 00 00 bb f4 ff ff ff e9 57 02 00 00 48 63 d1 48 c1 e2 04 48 03 50 20 48 8b 12 48 85 d2 74 0b 48 8b 92 d0 02 00 00 <48> 89 7a 38 ff c1 e9 15 f5 ff ff 48 c7 c7 00 a5 ac a1 49 c7 c7 20
<4>[    7.410236] RSP: 0000:ffffb14e40073dd0 EFLAGS: 00010282
<4>[    7.410240] RAX: ffff8d0643731720 RBX: 0000000000000000 RCX: 0000000000000000
<4>[    7.410244] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffffffffff
<4>[    7.410247] RBP: ffffb14e40073e90 R08: 0000000000000001 R09: ffff8d0643803700
<4>[    7.410250] R10: ffff8d0642620000 R11: 0000000000000016 R12: 000000000000000b
<4>[    7.410254] R13: ffff8d064361e650 R14: ffffffffa2455d80 R15: 0000000000000000
<4>[    7.410258] FS:  0000000000000000(0000) GS:ffff8d0647480000(0000) knlGS:0000000000000000
<4>[    7.410262] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[    7.410266] CR2: 0000000000000038 CR3: 000000056760a001 CR4: 00000000003706e0
<4>[    7.410269] Call Trace:
<4>[    7.410280]  ? call_rcu+0x10e/0x320
<4>[    7.410286]  ? trace_hardirqs_on+0x2c/0xd0
<4>[    7.410291]  ? rdinit_setup+0x2c/0x2c
<4>[    7.410297]  ? e820__memblock_setup+0x8b/0x8b
<4>[    7.410302]  pci_iommu_init+0x16/0x3f
<4>[    7.410307]  do_one_initcall+0x46/0x1e4
<4>[    7.410313]  kernel_init_freeable+0x169/0x1b2
<4>[    7.410320]  ? rest_init+0x9f/0x9f
<4>[    7.410325]  kernel_init+0xa/0x101
<4>[    7.410329]  ret_from_fork+0x22/0x30
<4>[    7.410333] Modules linked in:
<4>[    7.410338] CR2: 0000000000000038
<4>[    7.410344] ---[ end trace 16bcdb1e11668fcd ]---

Full kernel message is attached in kernel.log.

I tracked the problem down to the dev_iommu_priv_set call in init_no_remapping_devices. It seems that for one device the dev->iommu member is NULL.

An dev_err outputs the device as "pci 0000:00:02.0: DMAR" which is the intel HD 620 graphic adapter in a Lenovo T470s device.

The following patch (also attached as intel-iommu.patch) avoids this crash by checking the pointer.

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f8177c59d229..2d285a42db3f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4053,7 +4053,8 @@ static void __init init_no_remapping_devices(void)
                        drhd->ignored = 1;
                        for_each_active_dev_scope(drhd->devices,
                                                  drhd->devices_cnt, i, dev)
-                               dev_iommu_priv_set(dev, DUMMY_DEVICE_DOMAIN_INFO);
+                               if (dev->iommu)
+                                       dev_iommu_priv_set(dev, DUMMY_DEVICE_DOMAIN_INFO);
                }
        }
 }

I assume the problem might be related to the following commit introduced in v5.9-rc1:

commit 01b9d4e21148c89fdbab3d6b3705f9791314b631
Author: Joerg Roedel <jroedel@suse.de>
Date:   Thu Jun 25 15:08:25 2020 +0200

    iommu/vt-d: Use dev_iommu_priv_get/set()
    
    Remove the use of dev->archdata.iommu and use the private per-device
    pointer provided by IOMMU core code instead.

With regards,

	Torsten Hilbrich

-- 
Dipl.-Inform.
Torsten Hilbrich
Teamleiter Bereich Entwicklung
Abteilung Network & Client Security
Divison Public Authorities
secunet Security Networks AG 
Konrad-Zuse-Platz 2-4
81829 München

Tel: +49-201-5454-3522
Fax: +49-201-5454-1327
torsten.hilbrich@secunet.com
www.secunet.com

______________________________________________________________________

secunet Security Networks AG
Sitz: Kurfürstenstraße 58, 45138 Essen, Deutschland 
Amtsgericht Essen HRB 13615
Vorstand: Axel Deininger (Vors.), Torsten Henn, Dr. Kai Martius, Thomas
          Pleines
Aufsichtsratsvorsitzender: Ralf Wintergerst
______________________________________________________________________


--------------C3F9CFC4B3CABC675A65CB7D
Content-Type: text/x-log; charset="UTF-8"; name="kernel.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="kernel.log"

Oops#1 Part1
<6>[    0.000000] microcode: microcode updated early to revision 0xd6, da=
te =3D 2020-04-27
<5>[    0.000000] Linux version 5.9.0-devel+ (thilbrich@ts-6) (gcc (Debia=
n 8.3.0-6) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #2 SMP Mon Aug=
 31 09:20:36 CEST 2020
<6>[    0.000000] Command line: BOOT_IMAGE=3D/isolinux/bzImage console=3D=
tty1 intel_iommu=3Don,igfx_off loglevel=3D7 initcall_debug
<6>[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating =
point registers'
<6>[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers=
'
<6>[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers=
'
<6>[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds re=
gisters'
<6>[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
<6>[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
<6>[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
<6>[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
<6>[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is =
960 bytes, using 'compacted' format.
<6>[    0.000000] BIOS-provided physical RAM map:
<6>[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] =
usable
<6>[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] =
reserved
<6>[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009cfff] =
usable
<6>[    0.000000] BIOS-e820: [mem 0x000000000009d000-0x00000000000fffff] =
reserved
<6>[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000090b6cfff] =
usable
<6>[    0.000000] BIOS-e820: [mem 0x0000000090b6d000-0x0000000090b6dfff] =
ACPI NVS
<6>[    0.000000] BIOS-e820: [mem 0x0000000090b6e000-0x0000000090b6efff] =
reserved
<6>[    0.000000] BIOS-e820: [mem 0x0000000090b6f000-0x000000009a4abfff] =
usable
<6>[    0.000000] BIOS-e820: [mem 0x000000009a4ac000-0x000000009a573fff] =
type 20
<6>[    0.000000] BIOS-e820: [mem 0x000000009a574000-0x000000009b52bfff] =
reserved
<6>[    0.000000] BIOS-e820: [mem 0x000000009b52c000-0x000000009b54cfff] =
ACPI NVS
<6>[    0.000000] BIOS-e820: [mem 0x000000009b54d000-0x000000009b54dfff] =
reserved
<6>[    0.000000] BIOS-e820: [mem 0x000000009b54e000-0x000000009b599fff] =
ACPI NVS
<6>[    0.000000] BIOS-e820: [mem 0x000000009b59a000-0x000000009b5fefff] =
ACPI data
<6>[    0.000000] BIOS-e820: [mem 0x000000009b5ff000-0x000000009b5fffff] =
usable
<6>[    0.000000] BIOS-e820: [mem 0x000000009b600000-0x000000009f7fffff] =
reserved
<6>[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] =
reserved
<6>[    0.000000] BIOS-e820: [mem 0x00000000fe010000-0x00000000fe010fff] =
reserved
<6>[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000065f7fffff] =
usable
<6>[    0.000000] SMT: disabled
<6>[    0.000000] NX (Execute Disable) protection: active
<6>[    0.000000] user-defined physical RAM map:
<6>[    0.000000] user: [mem 0x0000000000000000-0x0000000000057fff] usabl=
e
<6>[    0.000000] user: [mem 0x0000000000058000-0x0000000000058fff] reser=
ved
<6>[    0.000000] user: [mem 0x0000000000059000-0x000000000009cfff] usabl=
e
<6>[    0.000000] user: [mem 0x000000000009d000-0x00000000000fffff] reser=
ved
<6>[    0.000000] user: [mem 0x0000000000100000-0x000000003fffffff] usabl=
e
<6>[    0.000000] user: [mem 0x0000000040000000-0x0000000041ffffff] reser=
ved
<6>[    0.000000] user: [mem 0x0000000042000000-0x0000000090b6cfff] usabl=
e
<6>[    0.000000] user: [mem 0x0000000090b6d000-0x0000000090b6dfff] ACPI =
NVS
<6>[    0.000000] user: [mem 0x0000000090b6e000-0x0000000090b6efff] reser=
ved
<6>[    0.000000] user: [mem 0x0000000090b6f000-0x000000009a4abfff] usabl=
e
<6>[    0.000000] user: [mem 0x000000009a4ac000-0x000000009a573fff] type =
20
<6>[    0.000000] user: [mem 0x000000009a574000-0x000000009b52bfff] reser=
ved
<6>[    0.000000] user: [mem 0x000000009b52c000-0x000000009b54cfff] ACPI =
NVS
<6>[    0.000000] user: [mem 0x000000009b54d000-0x000000009b54dfff] reser=
ved
<6>[    0.000000] user: [mem 0x000000009b54e000-0x000000009b599fff] ACPI =
NVS
<6>[    0.000000] user: [mem 0x000000009b59a000-0x000000009b5fefff] ACPI =
data
<6>[    0.000000] user: [mem 0x000000009b5ff000-0x000000009b5fffff] usabl=
e
<6>[    0.000000] user: [mem 0x000000009b600000-0x000000009f7fffff] reser=
ved
<6>[    0.000000] user: [mem 0x00000000f8000000-0x00000000fbffffff] reser=
ved
<6>[    0.000000] user: [mem 0x00000000fe010000-0x00000000fe010fff] reser=
ved
<6>[    0.000000] user: [mem 0x0000000100000000-0x000000065f7fffff] usabl=
e
<6>[    0.000000] efi: EFI v2.50 by Lenovo
<6>[    0.000000] efi: TPMFinalLog=3D0x9b592000 SMBIOS=3D0x9a6d8000 SMBIO=
S 3.0=3D0x9a6d5000 ACPI=3D0x9b5fe000 ACPI 2.0=3D0x9b5fe014 ESRT=3D0x9a5a2=
000 MEMATTR=3D0x953ed018=20
<6>[    0.000000] SMBIOS 3.0.0 present.
<6>[    0.000000] DMI: LENOVO 20HGS0TW00/20HGS0TW00, BIOS N1WET46S (1.25s=
 ) 03/30/2018
<6>[    0.000000] tsc: Detected 2900.000 MHz processor
<6>[    0.001243] tsc: Detected 2899.886 MHz TSC
<7>[    0.001243] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D>=
 reserved
<7>[    0.001247] e820: remove [mem 0x000a0000-0x000fffff] usable
<6>[    0.001260] last_pfn =3D 0x65f800 max_arch_pfn =3D 0x400000000
<7>[    0.001267] MTRR default type: write-back
<7>[    0.001268] MTRR fixed ranges enabled:
<7>[    0.001270]   00000-9FFFF write-back
<7>[    0.001272]   A0000-BFFFF uncachable
<7>[    0.001273]   C0000-FFFFF write-protect
<7>[    0.001275] MTRR variable ranges enabled:
<7>[    0.001277]   0 base 00C0000000 mask 7FC0000000 uncachable
<7>[    0.001279]   1 base 00A0000000 mask 7FE0000000 uncachable
<7>[    0.001281]   2 base 009E000000 mask 7FFE000000 uncachable
<7>[    0.001282]   3 base 009D000000 mask 7FFF000000 uncachable
<7>[    0.001283]   4 disabled
<7>[    0.001284]   5 disabled
<7>[    0.001285]   6 disabled
<7>[    0.001286]   7 disabled
<7>[    0.001286]   8 disabled
<7>[    0.001287]   9 disabled
<6>[    0.002158] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  U=
C- WT =20
<6>[    0.003267] last_pfn =3D 0x9b600 max_arch_pfn =3D 0x400000000
<6>[    0.025517] esrt: Reserving ESRT space from 0x000000009a5a2000 to 0=
x000000009a5a2088.
<6>[    0.025533] check: Scanning 1 areas for low memory corruption
<6>[    0.025542] Using GB pages for direct mapping
<6>[    0.026131] Secure boot could not be determined
<6>[    0.026134] RAMDISK: [mem 0x34215000-0x36101fff]
<6>[    0.026148] ACPI: Early table checksum verification disabled
<6>[    0.026153] ACPI: RSDP 0x000000009B5FE014 000024 (v02 LENOVO)
<6>[    0.026159] ACPI: XSDT 0x000000009B5C2188 000104 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026168] ACPI: FACP 0x000000009B5F5000 0000F4 (v05 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026177] ACPI: DSDT 0x000000009B5D0000 020CF2 (v02 LENOVO SKL   =
   00000000 INTL 20160527)
<6>[    0.026182] ACPI: FACS 0x000000009B53C000 000040
<6>[    0.026186] ACPI: SSDT 0x000000009B5FC000 0003CC (v02 LENOVO Tpm2Ta=
bl 00001000 INTL 20160527)
<6>[    0.026191] ACPI: TPM2 0x000000009B5FB000 000034 (v03 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026196] ACPI: UEFI 0x000000009B553000 000042 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026200] ACPI: SSDT 0x000000009B5F7000 003246 (v02 LENOVO SaSsdt=
   00003000 INTL 20160527)
<6>[    0.026205] ACPI: SSDT 0x000000009B5F6000 0005B6 (v02 LENOVO PerfTu=
ne 00001000 INTL 20160527)
<6>[    0.026209] ACPI: HPET 0x000000009B5F4000 000038 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026214] ACPI: APIC 0x000000009B5F3000 0000BC (v03 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026218] ACPI: MCFG 0x000000009B5F2000 00003C (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026223] ACPI: ECDT 0x000000009B5F1000 000053 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026227] ACPI: SSDT 0x000000009B5CE000 0016F3 (v02 LENOVO ProjSs=
dt 00000010 INTL 20160527)
<6>[    0.026232] ACPI: BOOT 0x000000009B5CD000 000028 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026237] ACPI: BATB 0x000000009B5CC000 00004A (v02 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026241] ACPI: SLIC 0x000000009B5CB000 000176 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026246] ACPI: SSDT 0x000000009B5C9000 0017AE (v02 LENOVO CpuSsd=
t  00003000 INTL 20160527)
<6>[    0.026250] ACPI: SSDT 0x000000009B5C8000 00056D (v02 LENOVO CtdpB =
   00001000 INTL 20160527)
<6>[    0.026255] ACPI: SSDT 0x000000009B5C7000 000634 (v02 LENOVO UsbCTa=
bl 00001000 INTL 20160527)
<6>[    0.026261] ACPI: WSMT 0x000000009B5C6000 000028 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026266] ACPI: SSDT 0x000000009B5C5000 000141 (v02 LENOVO HdaDsp=
   00000000 INTL 20160527)
<6>[    0.026272] ACPI: SSDT 0x000000009B5C4000 0004C5 (v02 LENOVO TbtTyp=
eC 00000000 INTL 20160527)
<6>[    0.026277] ACPI: DBGP 0x000000009B5C3000 000034 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026281] ACPI: DBG2 0x000000009B5FD000 000054 (v00 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026286] ACPI: MSDM 0x000000009B5C1000 000055 (v03 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026290] ACPI: DMAR 0x000000009B5C0000 0000A8 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026295] ACPI: ASF! 0x000000009B5BF000 0000A0 (v32 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026299] ACPI: FPDT 0x000000009B5BE000 000044 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026304] ACPI: BGRT 0x000000009B5BD000 000038 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026308] ACPI: UEFI 0x000000009B539000 00013E (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<7>[    0.026320] ACPI: Local APIC address 0xfee00000
<6>[    0.026579] No NUMA configuration found
<6>[    0.026582] Faking a node at [mem 0x0000000000000000-0x000000065f7f=
ffff]
<6>[    0.026588] NODE_DATA(0) allocated [mem 0x65f7fc000-0x65f7fffff]
<6>[    0.026631] Zone ranges:
<6>[    0.026632]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
<6>[    0.026635]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
<6>[    0.026637]   Normal   [mem 0x0000000100000000-0x000000065f7fffff]
<6>[    0.026639] Movable zone start for each node
<6>[    0.026641] Early memory node ranges
<6>[    0.026643]   node   0: [mem 0x0000000000001000-0x0000000000057fff]=

<6>[    0.026645]   node   0: [mem 0x0000000000059000-0x000000000009cfff]=

<6>[    0.026646]   node   0: [mem 0x0000000000100000-0x000000003fffffff]=

<6>[    0.026648]   node   0: [mem 0x0000000042000000-0x0000000090b6cfff]=

<6>[    0.026650]   node   0: [mem 0x0000000090b6f000-0x000000009a4abfff]=

<6>[    0.026651]   node   0: [mem 0x000000009b5ff000-0x000000009b5fffff]=

<6>[    0.026653]   node   0: [mem 0x0000000100000000-0x000000065f7fffff]=

<6>[    0.027245] Zeroed struct page in unavailable ranges: 33722 pages
<6>[    0.027247] Initmem setup node 0 [mem 0x0000000000001000-0x00000006=
5f7fffff]
<7>[    0.027250] On node 0 totalpages: 6257734
<7>[    0.027252]   DMA zone: 64 pages used for memmap
<7>[    0.027253]   DMA zone: 22 pages reserved
<7>[    0.027254]   DMA zone: 3995 pages, LIFO batch:0
<7>[    0.027294]   DMA32 zone: 9683 pages used for memmap
<7>[    0.027295]   DMA32 zone: 619691 pages, LIFO batch:63
<7>[    0.033401]   Normal zone: 88032 pages used for memmap
<7>[    0.033402]   Normal zone: 5634048 pages, LIFO batch:63
<6>[    0.088857] Reserving Intel graphics memory at [mem 0x9d800000-0x9f=
7fffff]
<6>[    0.089301] ACPI: PM-Timer IO Port: 0x1808
<7>[    0.089304] ACPI: Local APIC address 0xfee00000
<6>[    0.089313] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
<6>[    0.089314] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
<6>[    0.089316] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
<6>[    0.089317] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
<6>[    0.089319] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
<6>[    0.089320] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
<6>[    0.089321] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
<6>[    0.089323] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
<6>[    0.089356] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, G=
SI 0-119
<6>[    0.089360] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl=
)
<6>[    0.089362] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high le=
vel)
<7>[    0.089365] ACPI: IRQ0 used by override.
<7>[    0.089367] ACPI: IRQ9 used by override.
<6>[    0.089369] Using ACPI (MADT) for SMP configuration information
<6>[    0.089372] ACPI: HPET id: 0x8086a201 base: 0xfed00000
<7>[    0.089382] e820: update [mem 0x94dcc000-0x94f0bfff] usable =3D=3D>=
 reserved
<6>[    0.089396] TSC deadline timer available
<6>[    0.089398] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
<6>[    0.089431] [mem 0x9f800000-0xf7ffffff] available for PCI devices
<6>[    0.089436] clocksource: refined-jiffies: mask: 0xffffffff max_cycl=
es: 0xffffffff, max_idle_ns: 1910969940391419 ns
<6>[    0.101102] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4 =
nr_node_ids:1
<6>[    0.101359] percpu: Embedded 53 pages/cpu s176728 r8192 d32168 u524=
288
<7>[    0.101370] pcpu-alloc: s176728 r8192 d32168 u524288 alloc=3D1*2097=
152
<7>[    0.101371] pcpu-alloc: [0] 0 1 2 3=20
<6>[    0.101402] Built 1 zonelists, mobility grouping on.  Total pages: =
6159933
<6>[    0.101404] Policy zone: Normal
<5>[    0.101406] Kernel command line: memmap=3D0x2000000$0x40000000 ramo=
ops.mem_address=3D0x40000000 ramoops.mem_size=3D0x2000000 ramoops.ecc=3D1=
 ramoops.record_size=3D0x200000 ramoops.console_size=3D0 ramoops.ftrace_s=
ize=3D0 ramoops.pmsg_size=3D0 mem_sleep_default=3Ddeep l1tf=3Dfull mds=3D=
full nosmt BOOT_IMAGE=3D/isolinux/bzImage console=3Dtty1 intel_iommu=3Don=
,igfx_off loglevel=3D7 initcall_debug
<6>[    0.101684] DMAR: IOMMU enabled
<6>[    0.101686] DMAR: Disable GFX device mapping
<6>[    0.104787] Dentry cache hash table entries: 4194304 (order: 13, 33=
554432 bytes, linear)
<6>[    0.106343] Inode-cache hash table entries: 2097152 (order: 12, 167=
77216 bytes, linear)
<6>[    0.106416] mem auto-init: stack:off, heap alloc:off, heap free:off=

<6>[    0.195390] Memory: 24382024K/25030936K available (16387K kernel co=
de, 1782K rwdata, 5580K rodata, 1552K init, 4168K bss, 648652K reserved, =
0K cma-reserved)
<6>[    0.195462] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D=
4, Nodes=3D1
<6>[    0.195470] Kernel/User page tables isolation: enabled
<6>[    0.195511] ftrace: allocating 47289 entries in 185 pages
<6>[    0.231569] ftrace: allocated 185 pages with 5 groups
<6>[    0.231695] rcu: Hierarchical RCU implementation.
<6>[    0.231697] rcu: 	RCU event tracing is enabled.
<6>[    0.231699] rcu: 	RCU restricting CPUs from NR_CPUS=3D8 to nr_cpu_i=
ds=3D4.
<6>[    0.231701] 	Rude variant of Tasks RCU enabled.
<6>[    0.231703] rcu: RCU calculated value of scheduler-enlistment delay=
 is 100 jiffies.
<6>[    0.231705] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cp=
u_ids=3D4
<6>[    0.237369] NR_IRQS: 4352, nr_irqs: 1024, preallocated irqs: 16
<5>[    0.238309] random: get_random_bytes called from start_kernel+0x369=
/0x52c with crng_init=3D0
<7>[    0.238335] calling  con_init+0x0/0x233 @ 0
<6>[    0.238351] Console: colour dummy device 80x25
<6>[    0.238769] printk: console [tty1] enabled
<7>[    0.238775] initcall con_init+0x0/0x233 returned 0 after 0 usecs
<7>[    0.238777] calling  hvc_console_init+0x0/0x14 @ 0
<7>[    0.238781] initcall hvc_console_init+0x0/0x14 returned 0 after 0 u=
secs
<7>[    0.238783] calling  univ8250_console_init+0x0/0x27 @ 0
<7>[    0.238787] initcall univ8250_console_init+0x0/0x27 returned 0 afte=
r 0 usecs
<6>[    0.238807] ACPI: Core revision 20200717
<6>[    0.239308] clocksource: hpet: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 79635855245 ns
<6>[    0.239401] APIC: Switch to symmetric I/O mode setup
<6>[    0.243602] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pi=
n2=3D-1
<6>[    0.248381] clocksource: tsc-early: mask: 0xffffffffffffffff max_cy=
cles: 0x29ccd767b87, max_idle_ns: 440795223720 ns
<6>[    0.248391] Calibrating delay loop (skipped), value calculated usin=
g timer frequency.. 5799.77 BogoMIPS (lpj=3D2899886)
<6>[    0.248398] pid_max: default: 32768 minimum: 301
<6>[    0.253415] LSM: Security Framework initializing
<6>[    0.253515] Mount-cache hash table entries: 65536 (order: 7, 524288=
 bytes, linear)
<6>[    0.253601] Mountpoint-cache hash table entries: 65536 (order: 7, 5=
24288 bytes, linear)
<6>[    0.254006] mce: CPU0: Thermal monitoring enabled (TM1)
<6>[    0.254043] process: using mwait in idle threads
<6>[    0.254049] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
<6>[    0.254053] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
<6>[    0.254059] Spectre V1 : Mitigation: usercopy/swapgs barriers and _=
_user pointer sanitization
<6>[    0.254067] Spectre V2 : Mitigation: Full generic retpoline
<6>[    0.254070] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Fillin=
g RSB on context switch
<6>[    0.254074] Spectre V2 : Enabling Restricted Speculation for firmwa=
re calls
<6>[    0.254080] Spectre V2 : mitigation: Enabling conditional Indirect =
Branch Prediction Barrier
<6>[    0.254085] Spectre V2 : User space: Mitigation: STIBP via seccomp =
and prctl
<6>[    0.254091] Speculative Store Bypass: Mitigation: Speculative Store=
 Bypass disabled via prctl and seccomp
<6>[    0.254096] SMT: disabled
<6>[    0.254108] SRBDS: Mitigation: Microcode
<6>[    0.254111] MDS: Mitigation: Clear CPU buffers
<6>[    0.254837] Freeing SMP alternatives memory: 40K
<6>[    0.255517] smpboot: CPU0: Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz=
 (family: 0x6, model: 0x8e, stepping: 0x9)
<7>[    0.255657] calling  init_hw_perf_events+0x0/0x53b @ 1
<6>[    0.255658] Performance Events: PEBS fmt3+, Skylake events, 32-deep=
 LBR, full-width counters, Intel PMU driver.
<6>[    0.255677] ... version:                4
<6>[    0.255680] ... bit width:              48
<6>[    0.255683] ... generic registers:      4
<6>[    0.255686] ... value mask:             0000ffffffffffff
<6>[    0.255689] ... max period:             00007fffffffffff
<6>[    0.255692] ... fixed-purpose events:   3
<6>[    0.255695] ... event mask:             000000070000000f
<7>[    0.255730] initcall init_hw_perf_events+0x0/0x53b returned 0 after=
 0 usecs
<7>[    0.255733] calling  init_real_mode+0x0/0x1d2 @ 1
<7>[    0.255746] initcall init_real_mode+0x0/0x1d2 returned 0 after 0 us=
ecs
<7>[    0.255749] calling  trace_init_perf_perm_irq_work_exit+0x0/0x13 @ =
1
<7>[    0.255752] initcall trace_init_perf_perm_irq_work_exit+0x0/0x13 re=
turned 0 after 0 usecs
<7>[    0.255756] calling  validate_x2apic+0x0/0x4e @ 1
<7>[    0.255759] initcall validate_x2apic+0x0/0x4e returned 0 after 0 us=
ecs
<7>[    0.255762] calling  register_nmi_cpu_backtrace_handler+0x0/0x16 @ =
1
<7>[    0.255766] initcall register_nmi_cpu_backtrace_handler+0x0/0x16 re=
turned 0 after 0 usecs
<7>[    0.255769] calling  spawn_ksoftirqd+0x0/0x39 @ 1
<7>[    0.255802] initcall spawn_ksoftirqd+0x0/0x39 returned 0 after 0 us=
ecs
<7>[    0.255805] calling  migration_init+0x0/0x34 @ 1
<7>[    0.255807] initcall migration_init+0x0/0x34 returned 0 after 0 use=
cs
<7>[    0.255810] calling  srcu_bootup_announce+0x0/0x30 @ 1
<6>[    0.255811] rcu: Hierarchical SRCU implementation.
<7>[    0.255817] initcall srcu_bootup_announce+0x0/0x30 returned 0 after=
 0 usecs
<7>[    0.255820] calling  rcu_spawn_core_kthreads+0x0/0x7c @ 1
<7>[    0.255823] initcall rcu_spawn_core_kthreads+0x0/0x7c returned 0 af=
ter 0 usecs
<7>[    0.255826] calling  rcu_spawn_gp_kthread+0x0/0x137 @ 1
<7>[    0.255846] initcall rcu_spawn_gp_kthread+0x0/0x137 returned 0 afte=
r 0 usecs
<7>[    0.255849] calling  check_cpu_stall_init+0x0/0x1b @ 1
<7>[    0.255852] initcall check_cpu_stall_init+0x0/0x1b returned 0 after=
 0 usecs
<7>[    0.255854] calling  rcu_sysrq_init+0x0/0x22 @ 1
<7>[    0.255857] initcall rcu_sysrq_init+0x0/0x22 returned 0 after 0 use=
cs
<7>[    0.255860] calling  trace_init_flags_sys_enter+0x0/0xf @ 1
<7>[    0.255864] initcall trace_init_flags_sys_enter+0x0/0xf returned 0 =
after 0 usecs
<7>[    0.255866] calling  trace_init_flags_sys_exit+0x0/0xf @ 1
<7>[    0.255869] initcall trace_init_flags_sys_exit+0x0/0xf returned 0 a=
fter 0 usecs
<7>[    0.255872] calling  cpu_stop_init+0x0/0x86 @ 1
<7>[    0.255900] initcall cpu_stop_init+0x0/0x86 returned 0 after 0 usec=
s
<7>[    0.255904] calling  init_events+0x0/0x40 @ 1
<7>[    0.255918] initcall init_events+0x0/0x40 returned 0 after 0 usecs
<7>[    0.255921] calling  init_trace_printk+0x0/0xc @ 1
<7>[    0.255925] initcall init_trace_printk+0x0/0xc returned 0 after 0 u=
secs
<7>[    0.255929] calling  event_trace_enable_again+0x0/0x3e @ 1
<7>[    0.255933] initcall event_trace_enable_again+0x0/0x3e returned 0 a=
fter 0 usecs
<7>[    0.255936] calling  jump_label_init_module+0x0/0x11 @ 1
<7>[    0.255939] initcall jump_label_init_module+0x0/0x11 returned 0 aft=
er 0 usecs
<7>[    0.255947] calling  dynamic_debug_init+0x0/0x1ae @ 1
<7>[    0.256124] initcall dynamic_debug_init+0x0/0x1ae returned 0 after =
0 usecs
<7>[    0.256127] calling  initialize_ptr_random+0x0/0x4b @ 1
<7>[    0.256149] initcall initialize_ptr_random+0x0/0x4b returned 0 afte=
r 0 usecs
<7>[    0.256152] calling  efi_memreserve_root_init+0x0/0x26 @ 1
<7>[    0.256155] initcall efi_memreserve_root_init+0x0/0x26 returned 0 a=
fter 0 usecs
<7>[    0.256158] calling  efi_earlycon_remap_fb+0x0/0x4e @ 1
<7>[    0.256161] initcall efi_earlycon_remap_fb+0x0/0x4e returned 0 afte=
r 0 usecs
<6>[    0.256558] NMI watchdog: Enabled. Permanently consumes one hw-PMU =
counter.
<6>[    0.256638] smp: Bringing up secondary CPUs ...
<6>[    0.256754] x86: Booting SMP configuration:
<6>[    0.256759] .... node  #0, CPUs:      #1 #2 #3
<6>[    0.267160] smp: Brought up 1 node, 2 CPUs
<6>[    0.267171] smpboot: Max logical packages: 2
<6>[    0.267176] smpboot: Total of 2 processors activated (11599.54 Bogo=
MIPS)
<6>[    0.267938] devtmpfs: initialized
<7>[    0.267938] calling  ipc_ns_init+0x0/0x3f @ 1
<7>[    0.267938] initcall ipc_ns_init+0x0/0x3f returned 0 after 0 usecs
<7>[    0.267938] calling  init_mmap_min_addr+0x0/0x16 @ 1
<7>[    0.267938] initcall init_mmap_min_addr+0x0/0x16 returned 0 after 0=
 usecs
<7>[    0.267938] calling  pci_realloc_setup_params+0x0/0x41 @ 1
<7>[    0.267938] initcall pci_realloc_setup_params+0x0/0x41 returned 0 a=
fter 0 usecs
<7>[    0.267938] calling  net_ns_init+0x0/0x11d @ 1
<7>[    0.268395] initcall net_ns_init+0x0/0x11d returned 0 after 0 usecs=

<7>[    0.268395] calling  e820__register_nvs_regions+0x0/0x38 @ 1
<6>[    0.268395] PM: Registering ACPI NVS region [mem 0x90b6d000-0x90b6d=
fff] (4096 bytes)
<6>[    0.268395] PM: Registering ACPI NVS region [mem 0x9b52c000-0x9b54c=
fff] (135168 bytes)
<6>[    0.268395] PM: Registering ACPI NVS region [mem 0x9b54e000-0x9b599=
fff] (311296 bytes)
<7>[    0.268395] initcall e820__register_nvs_regions+0x0/0x38 returned 0=
 after 0 usecs
<7>[    0.268395] calling  cpufreq_register_tsc_scaling+0x0/0x2a @ 1
<7>[    0.268395] initcall cpufreq_register_tsc_scaling+0x0/0x2a returned=
 0 after 0 usecs
<7>[    0.268395] calling  reboot_init+0x0/0x3d @ 1
<7>[    0.268395] initcall reboot_init+0x0/0x3d returned 0 after 0 usecs
<7>[    0.268395] calling  init_lapic_sysfs+0x0/0x21 @ 1
<7>[    0.268395] initcall init_lapic_sysfs+0x0/0x21 returned 0 after 0 u=
secs
<7>[    0.268395] calling  alloc_frozen_cpus+0x0/0x8 @ 1
<7>[    0.268395] initcall alloc_frozen_cpus+0x0/0x8 returned 0 after 0 u=
secs
<7>[    0.268395] calling  cpu_hotplug_pm_sync_init+0x0/0x14 @ 1
<7>[    0.268395] initcall cpu_hotplug_pm_sync_init+0x0/0x14 returned 0 a=
fter 0 usecs
<7>[    0.268395] calling  wq_sysfs_init+0x0/0x2b @ 1
<7>[    0.268395] initcall wq_sysfs_init+0x0/0x2b returned 0 after 0 usec=
s
<7>[    0.268395] calling  ksysfs_init+0x0/0x93 @ 1
<7>[    0.268395] initcall ksysfs_init+0x0/0x93 returned 0 after 0 usecs
<7>[    0.268395] calling  schedutil_gov_init+0x0/0x11 @ 1
<7>[    0.268395] initcall schedutil_gov_init+0x0/0x11 returned 0 after 0=
 usecs
<7>[    0.268395] calling  pm_init+0x0/0x69 @ 1
<7>[    0.268395] initcall pm_init+0x0/0x69 returned 0 after 0 usecs
<7>[    0.268395] calling  rcu_set_runtime_mode+0x0/0x17 @ 1
<7>[    0.268395] initcall rcu_set_runtime_mode+0x0/0x17 returned 0 after=
 0 usecs
<7>[    0.268395] calling  rcu_spawn_tasks_rude_kthread+0x0/0x70 @ 1
<7>[    0.268410] initcall rcu_spawn_tasks_rude_kthread+0x0/0x70 returned=
 0 after 0 usecs
<7>[    0.268410] calling  init_jiffies_clocksource+0x0/0x18 @ 1
<6>[    0.268410] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xff=
ffffff, max_idle_ns: 1911260446275000 ns
<7>[    0.268419] initcall init_jiffies_clocksource+0x0/0x18 returned 0 a=
fter 0 usecs
<7>[    0.268422] calling  futex_init+0x0/0xf7 @ 1
<6>[    0.268427] futex hash table entries: 1024 (order: 4, 65536 bytes, =
linear)
<7>[    0.268446] initcall futex_init+0x0/0xf7 returned 0 after 0 usecs
<7>[    0.268449] calling  cgroup_wq_init+0x0/0x29 @ 1
<7>[    0.268467] initcall cgroup_wq_init+0x0/0x29 returned 0 after 0 use=
cs
<7>[    0.268471] calling  cgroup1_wq_init+0x0/0x29 @ 1
<7>[    0.268485] initcall cgroup1_wq_init+0x0/0x29 returned 0 after 0 us=
ecs
<7>[    0.268489] calling  ftrace_mod_cmd_init+0x0/0x9 @ 1
<7>[    0.268494] initcall ftrace_mod_cmd_init+0x0/0x9 returned 0 after 0=
 usecs
<7>[    0.268498] calling  init_irqsoff_tracer+0x0/0xf @ 1
<7>[    0.268504] initcall init_irqsoff_tracer+0x0/0xf returned 0 after 0=
 usecs
<7>[    0.268507] calling  init_wakeup_tracer+0x0/0x2d @ 1
<7>[    0.268512] initcall init_wakeup_tracer+0x0/0x2d returned 0 after 0=
 usecs
<7>[    0.268516] calling  init_graph_trace+0x0/0x5d @ 1
<7>[    0.268525] initcall init_graph_trace+0x0/0x5d returned 0 after 0 u=
secs
<7>[    0.268528] calling  init_zero_pfn+0x0/0x38 @ 1
<7>[    0.268531] initcall init_zero_pfn+0x0/0x38 returned 0 after 0 usec=
s
<7>[    0.268534] calling  fsnotify_init+0x0/0x49 @ 1
<7>[    0.268547] initcall fsnotify_init+0x0/0x49 returned 0 after 0 usec=
s
<7>[    0.268550] calling  filelock_init+0x0/0x98 @ 1
<7>[    0.268560] initcall filelock_init+0x0/0x98 returned 0 after 0 usec=
s
<7>[    0.268564] calling  init_script_binfmt+0x0/0x16 @ 1
<7>[    0.268568] initcall init_script_binfmt+0x0/0x16 returned 0 after 0=
 usecs
<7>[    0.268571] calling  init_elf_binfmt+0x0/0x16 @ 1
<7>[    0.268575] initcall init_elf_binfmt+0x0/0x16 returned 0 after 0 us=
ecs
<7>[    0.268579] calling  debugfs_init+0x0/0x5d @ 1
<7>[    0.268586] initcall debugfs_init+0x0/0x5d returned 0 after 0 usecs=

<7>[    0.268590] calling  tracefs_init+0x0/0x3b @ 1
<7>[    0.268595] initcall tracefs_init+0x0/0x3b returned 0 after 0 usecs=

<7>[    0.268598] calling  prandom_init+0x0/0xb8 @ 1
<7>[    0.268674] initcall prandom_init+0x0/0xb8 returned 0 after 0 usecs=

<7>[    0.268676] calling  pinctrl_init+0x0/0xae @ 1
<6>[    0.268678] pinctrl core: initialized pinctrl subsystem
<7>[    0.268704] initcall pinctrl_init+0x0/0xae returned 0 after 0 usecs=

<7>[    0.268707] calling  gpiolib_dev_init+0x0/0xc2 @ 1
<7>[    0.268722] initcall gpiolib_dev_init+0x0/0xc2 returned 0 after 0 u=
secs
<7>[    0.268727] calling  virtio_init+0x0/0x20 @ 1
<7>[    0.268743] initcall virtio_init+0x0/0x20 returned 0 after 0 usecs
<7>[    0.268752] calling  iommu_init+0x0/0x2b @ 1
<7>[    0.268756] initcall iommu_init+0x0/0x2b returned 0 after 0 usecs
<7>[    0.268760] calling  component_debug_init+0x0/0x1d @ 1
<7>[    0.268765] initcall component_debug_init+0x0/0x1d returned 0 after=
 0 usecs
<7>[    0.268768] calling  early_resume_init+0x0/0xa4 @ 1
<6>[    0.268868] PM: RTC time: 08:36:13, date: 2020-08-31
<7>[    0.268875] initcall early_resume_init+0x0/0xa4 returned 0 after 0 =
usecs
<7>[    0.268878] calling  cpufreq_core_init+0x0/0x63 @ 1
<7>[    0.268882] initcall cpufreq_core_init+0x0/0x63 returned 0 after 0 =
usecs
<7>[    0.268885] calling  cpufreq_gov_performance_init+0x0/0x11 @ 1
<7>[    0.268888] initcall cpufreq_gov_performance_init+0x0/0x11 returned=
 0 after 0 usecs
<7>[    0.268890] calling  cpufreq_gov_userspace_init+0x0/0x11 @ 1
<7>[    0.268893] initcall cpufreq_gov_userspace_init+0x0/0x11 returned 0=
 after 0 usecs
<7>[    0.268895] calling  CPU_FREQ_GOV_ONDEMAND_init+0x0/0x11 @ 1
<7>[    0.268898] initcall CPU_FREQ_GOV_ONDEMAND_init+0x0/0x11 returned 0=
 after 0 usecs
<7>[    0.268900] calling  CPU_FREQ_GOV_CONSERVATIVE_init+0x0/0x11 @ 1
<7>[    0.269394] initcall CPU_FREQ_GOV_CONSERVATIVE_init+0x0/0x11 return=
ed 0 after 0 usecs
<7>[    0.269396] calling  cpuidle_init+0x0/0x20 @ 1
<7>[    0.269403] initcall cpuidle_init+0x0/0x20 returned 0 after 0 usecs=

<7>[    0.269406] calling  capsule_reboot_register+0x0/0x11 @ 1
<7>[    0.269409] initcall capsule_reboot_register+0x0/0x11 returned 0 af=
ter 0 usecs
<7>[    0.269413] calling  sock_init+0x0/0x94 @ 1
<7>[    0.269512] initcall sock_init+0x0/0x94 returned 0 after 0 usecs
<7>[    0.269516] calling  net_inuse_init+0x0/0x24 @ 1
<7>[    0.269522] initcall net_inuse_init+0x0/0x24 returned 0 after 0 use=
cs
<7>[    0.269526] calling  net_defaults_init+0x0/0x24 @ 1
<7>[    0.269530] initcall net_defaults_init+0x0/0x24 returned 0 after 0 =
usecs
<7>[    0.269534] calling  init_default_flow_dissectors+0x0/0x50 @ 1
<7>[    0.269538] initcall init_default_flow_dissectors+0x0/0x50 returned=
 0 after 0 usecs
<7>[    0.269542] calling  netlink_proto_init+0x0/0x181 @ 1
<6>[    0.269575] NET: Registered protocol family 16
<7>[    0.269596] initcall netlink_proto_init+0x0/0x181 returned 0 after =
0 usecs
<7>[    0.269599] calling  genl_init+0x0/0x36 @ 1
<7>[    0.269608] initcall genl_init+0x0/0x36 returned 0 after 0 usecs
<7>[    0.269612] calling  bsp_pm_check_init+0x0/0x14 @ 1
<7>[    0.269616] initcall bsp_pm_check_init+0x0/0x14 returned 0 after 0 =
usecs
<7>[    0.269785] calling  irq_sysfs_init+0x0/0x94 @ 1
<7>[    0.269882] initcall irq_sysfs_init+0x0/0x94 returned 0 after 0 use=
cs
<7>[    0.269886] calling  release_early_probes+0x0/0x38 @ 1
<7>[    0.269890] initcall release_early_probes+0x0/0x38 returned 0 after=
 0 usecs
<7>[    0.269892] calling  bdi_class_init+0x0/0x49 @ 1
<7>[    0.269902] initcall bdi_class_init+0x0/0x49 returned 0 after 0 use=
cs
<7>[    0.269904] calling  mm_sysfs_init+0x0/0x29 @ 1
<7>[    0.269909] initcall mm_sysfs_init+0x0/0x29 returned 0 after 0 usec=
s
<7>[    0.269913] calling  init_per_zone_wmark_min+0x0/0x70 @ 1
<7>[    0.269921] initcall init_per_zone_wmark_min+0x0/0x70 returned 0 af=
ter 0 usecs
<7>[    0.269925] calling  ramoops_init+0x0/0x164 @ 1
<6>[    0.269927] ramoops: using module parameters
<6>[    0.487330] pstore: Registered ramoops as persistent store backend
<6>[    0.487335] ramoops: using 0x2000000@0x40000000, ecc: 16
<7>[    0.487354] initcall ramoops_init+0x0/0x164 returned 0 after 211914=
 usecs
<7>[    0.487357] calling  kobject_uevent_init+0x0/0xc @ 1
<7>[    0.487365] initcall kobject_uevent_init+0x0/0xc returned 0 after 0=
 usecs
<7>[    0.487367] calling  gpiolib_sysfs_init+0x0/0xa0 @ 1
<7>[    0.487375] initcall gpiolib_sysfs_init+0x0/0xa0 returned 0 after 0=
 usecs
<7>[    0.487378] calling  acpi_gpio_setup_params+0x0/0x68 @ 1
<7>[    0.487382] initcall acpi_gpio_setup_params+0x0/0x68 returned 0 aft=
er 0 usecs
<7>[    0.487384] calling  pcibus_class_init+0x0/0x18 @ 1
<7>[    0.487388] initcall pcibus_class_init+0x0/0x18 returned 0 after 0 =
usecs
<7>[    0.487391] calling  pci_driver_init+0x0/0x22 @ 1
<7>[    0.487408] initcall pci_driver_init+0x0/0x22 returned 0 after 0 us=
ecs
<7>[    0.487411] calling  backlight_class_init+0x0/0xa6 @ 1
<7>[    0.487417] initcall backlight_class_init+0x0/0xa6 returned 0 after=
 0 usecs
<7>[    0.487419] calling  tty_class_init+0x0/0x34 @ 1
<7>[    0.487423] initcall tty_class_init+0x0/0x34 returned 0 after 0 use=
cs
<7>[    0.487425] calling  vtconsole_class_init+0x0/0xd8 @ 1
<7>[    0.487447] initcall vtconsole_class_init+0x0/0xd8 returned 0 after=
 0 usecs
<7>[    0.487450] calling  iommu_dev_init+0x0/0x18 @ 1
<7>[    0.487455] initcall iommu_dev_init+0x0/0x18 returned 0 after 0 use=
cs
<7>[    0.487457] calling  mipi_dsi_bus_init+0x0/0x11 @ 1
<7>[    0.487468] initcall mipi_dsi_bus_init+0x0/0x11 returned 0 after 0 =
usecs
<7>[    0.487471] calling  devlink_class_init+0x0/0x41 @ 1
<7>[    0.487476] initcall devlink_class_init+0x0/0x41 returned 0 after 0=
 usecs
<7>[    0.487479] calling  software_node_init+0x0/0x2b @ 1
<7>[    0.487483] initcall software_node_init+0x0/0x2b returned 0 after 0=
 usecs
<7>[    0.487486] calling  wakeup_sources_debugfs_init+0x0/0x24 @ 1
<7>[    0.487492] initcall wakeup_sources_debugfs_init+0x0/0x24 returned =
0 after 0 usecs
<7>[    0.487494] calling  wakeup_sources_sysfs_init+0x0/0x30 @ 1
<7>[    0.487499] initcall wakeup_sources_sysfs_init+0x0/0x30 returned 0 =
after 0 usecs
<7>[    0.487502] calling  register_node_type+0x0/0x18 @ 1
<7>[    0.487522] initcall register_node_type+0x0/0x18 returned 0 after 0=
 usecs
<7>[    0.487524] calling  regmap_initcall+0x0/0xd @ 1
<7>[    0.487529] initcall regmap_initcall+0x0/0xd returned 0 after 0 use=
cs
<7>[    0.487531] calling  i2c_init+0x0/0xb4 @ 1
<7>[    0.487546] initcall i2c_init+0x0/0xb4 returned 0 after 0 usecs
<7>[    0.487548] calling  thermal_init+0x0/0x114 @ 1
<6>[    0.487550] thermal_sys: Registered thermal governor 'step_wise'
<6>[    0.487551] thermal_sys: Registered thermal governor 'user_space'
<7>[    0.487559] initcall thermal_init+0x0/0x114 returned 0 after 0 usec=
s
<7>[    0.487563] calling  init_menu+0x0/0x11 @ 1
<6>[    0.487574] cpuidle: using governor menu
<7>[    0.487578] initcall init_menu+0x0/0x11 returned 0 after 0 usecs
<7>[    0.487581] calling  pcc_init+0x0/0x93 @ 1
<7>[    0.487586] initcall pcc_init+0x0/0x93 returned -19 after 0 usecs
<7>[    0.487590] calling  amd_postcore_init+0x0/0x11a @ 1
<7>[    0.487593] initcall amd_postcore_init+0x0/0x11a returned 0 after 0=
 usecs
<7>[    0.487736] calling  bts_init+0x0/0xbb @ 1
<7>[    0.487739] initcall bts_init+0x0/0xbb returned -19 after 0 usecs
<7>[    0.487741] calling  pt_init+0x0/0x33c @ 1
<7>[    0.487745] initcall pt_init+0x0/0x33c returned 0 after 0 usecs
<7>[    0.487745] calling  boot_params_ksysfs_init+0x0/0x296 @ 1
<7>[    0.487745] initcall boot_params_ksysfs_init+0x0/0x296 returned 0 a=
fter 0 usecs
<7>[    0.487745] calling  sbf_init+0x0/0xcb @ 1
<6>[    0.487745] Simple Boot Flag at 0x47 set to 0x1
<7>[    0.487745] initcall sbf_init+0x0/0xcb returned 0 after 0 usecs
<7>[    0.487745] calling  arch_kdebugfs_init+0x0/0x1cc @ 1
<7>[    0.487745] initcall arch_kdebugfs_init+0x0/0x1cc returned 0 after =
0 usecs
<7>[    0.487745] calling  intel_pconfig_init+0x0/0x82 @ 1
<7>[    0.487745] initcall intel_pconfig_init+0x0/0x82 returned 0 after 0=
 usecs
<7>[    0.487745] calling  mtrr_if_init+0x0/0x5e @ 1
<7>[    0.487745] initcall mtrr_if_init+0x0/0x5e returned 0 after 0 usecs=

<7>[    0.487745] calling  ffh_cstate_init+0x0/0x2a @ 1
<7>[    0.487745] initcall ffh_cstate_init+0x0/0x2a returned 0 after 0 us=
ecs
<7>[    0.487745] calling  cryptomgr_init+0x0/0x11 @ 1
<7>[    0.487745] initcall cryptomgr_init+0x0/0x11 returned 0 after 0 use=
cs
<7>[    0.487745] calling  acpi_pci_init+0x0/0x5d @ 1
<6>[    0.487745] ACPI FADT declares the system doesn't support PCIe ASPM=
, so disable it
<6>[    0.487745] ACPI: bus type PCI registered
<6>[    0.487745] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0=
=2E5
<7>[    0.487745] initcall acpi_pci_init+0x0/0x5d returned 0 after 0 usec=
s
<7>[    0.487745] calling  dma_channel_table_init+0x0/0xdc @ 1
<7>[    0.487745] initcall dma_channel_table_init+0x0/0xdc returned 0 aft=
er 0 usecs
<7>[    0.487745] calling  dma_bus_init+0x0/0xe2 @ 1
<7>[    0.487745] initcall dma_bus_init+0x0/0xe2 returned 0 after 0 usecs=

<7>[    0.487745] calling  iommu_dma_init+0x0/0x10 @ 1
<7>[    0.487745] initcall iommu_dma_init+0x0/0x10 returned 0 after 0 use=
cs
<7>[    0.487745] calling  dmi_id_init+0x0/0x37d @ 1
<7>[    0.487745] initcall dmi_id_init+0x0/0x37d returned 0 after 0 usecs=

<7>[    0.487745] calling  pci_arch_init+0x0/0x66 @ 1
<6>[    0.487745] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf80=
00000-0xfbffffff] (base 0xf8000000)
<6>[    0.487745] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved i=
n E820
<6>[    0.487747] PCI: Using configuration type 1 for base access
<7>[    0.487755] initcall pci_arch_init+0x0/0x66 returned 0 after 0 usec=
s
<7>[    0.487894] calling  init_vdso+0x0/0x14 @ 1
<7>[    0.487900] initcall init_vdso+0x0/0x14 returned 0 after 0 usecs
<7>[    0.487902] calling  fixup_ht_bug+0x0/0xb2 @ 1
<7>[    0.487905] initcall fixup_ht_bug+0x0/0xb2 returned 0 after 0 usecs=

<7>[    0.487908] calling  topology_init+0x0/0x8e @ 1
<7>[    0.488462] initcall topology_init+0x0/0x8e returned 0 after 976 us=
ecs
<7>[    0.488466] calling  intel_epb_init+0x0/0x69 @ 1
<4>[    0.488472] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
<7>[    0.488483] initcall intel_epb_init+0x0/0x69 returned 0 after 0 use=
cs
<7>[    0.488483] calling  mtrr_init_finialize+0x0/0x3f @ 1
<7>[    0.488483] initcall mtrr_init_finialize+0x0/0x3f returned 0 after =
0 usecs
<7>[    0.488483] calling  uid_cache_init+0x0/0x92 @ 1
<7>[    0.488483] initcall uid_cache_init+0x0/0x92 returned 0 after 0 use=
cs
<7>[    0.488483] calling  param_sysfs_init+0x0/0x1b6 @ 1
<7>[    0.491892] initcall param_sysfs_init+0x0/0x1b6 returned 0 after 29=
29 usecs
<7>[    0.491895] calling  user_namespace_sysctl_init+0x0/0x34 @ 1
<7>[    0.491918] initcall user_namespace_sysctl_init+0x0/0x34 returned 0=
 after 0 usecs
<7>[    0.491920] calling  proc_schedstat_init+0x0/0x25 @ 1
<7>[    0.491926] initcall proc_schedstat_init+0x0/0x25 returned 0 after =
0 usecs
<7>[    0.491928] calling  pm_sysrq_init+0x0/0x19 @ 1
<7>[    0.491939] initcall pm_sysrq_init+0x0/0x19 returned 0 after 0 usec=
s
<7>[    0.491942] calling  time_ns_init+0x0/0x8 @ 1
<7>[    0.491945] initcall time_ns_init+0x0/0x8 returned 0 after 0 usecs
<7>[    0.491947] calling  cgroup_sysfs_init+0x0/0x18 @ 1
<7>[    0.491953] initcall cgroup_sysfs_init+0x0/0x18 returned 0 after 0 =
usecs
<7>[    0.491956] calling  cgroup_namespaces_init+0x0/0x8 @ 1
<7>[    0.491959] initcall cgroup_namespaces_init+0x0/0x8 returned 0 afte=
r 0 usecs
<7>[    0.491962] calling  init_kprobes+0x0/0x191 @ 1
<7>[    0.492314] initcall init_kprobes+0x0/0x191 returned 0 after 0 usec=
s
<7>[    0.492317] calling  hung_task_init+0x0/0x5b @ 1
<7>[    0.492322] initcall hung_task_init+0x0/0x5b returned 0 after 0 use=
cs
<7>[    0.492322] calling  send_signal_irq_work_init+0x0/0x49 @ 1
<7>[    0.492322] initcall send_signal_irq_work_init+0x0/0x49 returned 0 =
after 0 usecs
<7>[    0.492322] calling  init_kprobe_trace_early+0x0/0x26 @ 1
<7>[    0.492322] initcall init_kprobe_trace_early+0x0/0x26 returned 0 af=
ter 0 usecs
<7>[    0.492322] calling  dev_map_init+0x0/0x4d @ 1
<7>[    0.492322] initcall dev_map_init+0x0/0x4d returned 0 after 0 usecs=

<7>[    0.492322] calling  cpu_map_init+0x0/0x41 @ 1
<7>[    0.492322] initcall cpu_map_init+0x0/0x41 returned 0 after 0 usecs=

<7>[    0.492322] calling  netns_bpf_init+0x0/0x11 @ 1
<7>[    0.492322] initcall netns_bpf_init+0x0/0x11 returned 0 after 0 use=
cs
<7>[    0.492322] calling  stack_map_init+0x0/0x4e @ 1
<7>[    0.492322] initcall stack_map_init+0x0/0x4e returned 0 after 0 use=
cs
<7>[    0.492322] calling  oom_init+0x0/0x30 @ 1
<7>[    0.492418] initcall oom_init+0x0/0x30 returned 0 after 976 usecs
<7>[    0.492418] calling  default_bdi_init+0x0/0x36 @ 1
<7>[    0.492421] initcall default_bdi_init+0x0/0x36 returned 0 after 0 u=
secs
<7>[    0.492423] calling  percpu_enable_async+0x0/0xf @ 1
<7>[    0.492425] initcall percpu_enable_async+0x0/0xf returned 0 after 0=
 usecs
<7>[    0.492427] calling  kcompactd_init+0x0/0x90 @ 1
<7>[    0.492432] initcall kcompactd_init+0x0/0x90 returned 0 after 0 use=
cs
<7>[    0.492432] calling  init_user_reserve+0x0/0x40 @ 1
<7>[    0.492432] initcall init_user_reserve+0x0/0x40 returned 0 after 0 =
usecs
<7>[    0.492432] calling  init_admin_reserve+0x0/0x40 @ 1
<7>[    0.492432] initcall init_admin_reserve+0x0/0x40 returned 0 after 0=
 usecs
<7>[    0.492432] calling  init_reserve_notifier+0x0/0x3 @ 1
<7>[    0.492432] initcall init_reserve_notifier+0x0/0x3 returned 0 after=
 0 usecs
<7>[    0.492432] calling  swap_init_sysfs+0x0/0x63 @ 1
<7>[    0.492432] initcall swap_init_sysfs+0x0/0x63 returned 0 after 0 us=
ecs
<7>[    0.492432] calling  swapfile_init+0x0/0x96 @ 1
<7>[    0.492432] initcall swapfile_init+0x0/0x96 returned 0 after 0 usec=
s
<7>[    0.492432] calling  seqiv_module_init+0x0/0x11 @ 1
<7>[    0.492432] initcall seqiv_module_init+0x0/0x11 returned 0 after 0 =
usecs
<7>[    0.492433] calling  echainiv_module_init+0x0/0x11 @ 1
<7>[    0.492435] initcall echainiv_module_init+0x0/0x11 returned 0 after=
 0 usecs
<7>[    0.492439] calling  rsa_init+0x0/0x50 @ 1
<7>[    0.492444] initcall rsa_init+0x0/0x50 returned 0 after 0 usecs
<7>[    0.492444] calling  crypto_cmac_module_init+0x0/0x11 @ 1
<7>[    0.492444] initcall crypto_cmac_module_init+0x0/0x11 returned 0 af=
ter 0 usecs
<7>[    0.492444] calling  hmac_module_init+0x0/0x11 @ 1
<7>[    0.492444] initcall hmac_module_init+0x0/0x11 returned 0 after 0 u=
secs
<6>[    0.492444] cryptomgr_test (36) used greatest stack depth: 15728 by=
tes left
<7>[    0.492444] calling  crypto_null_mod_init+0x0/0x66 @ 1
<7>[    0.492444] initcall crypto_null_mod_init+0x0/0x66 returned 0 after=
 0 usecs
<7>[    0.492444] calling  rmd160_mod_init+0x0/0x11 @ 1
<7>[    0.492444] initcall rmd160_mod_init+0x0/0x11 returned 0 after 0 us=
ecs
<7>[    0.492444] calling  sha1_generic_mod_init+0x0/0x11 @ 1
<7>[    0.492444] initcall sha1_generic_mod_init+0x0/0x11 returned 0 afte=
r 0 usecs
<7>[    0.492444] calling  sha256_generic_mod_init+0x0/0x16 @ 1
<7>[    0.492444] initcall sha256_generic_mod_init+0x0/0x16 returned 0 af=
ter 0 usecs
<7>[    0.492444] calling  sha512_generic_mod_init+0x0/0x16 @ 1
<7>[    0.492444] initcall sha512_generic_mod_init+0x0/0x16 returned 0 af=
ter 0 usecs
<7>[    0.492444] calling  crypto_ecb_module_init+0x0/0x11 @ 1
<7>[    0.492444] initcall crypto_ecb_module_init+0x0/0x11 returned 0 aft=
er 0 usecs
<7>[    0.492444] calling  crypto_cbc_module_init+0x0/0x11 @ 1
<7>[    0.492444] initcall crypto_cbc_module_init+0x0/0x11 returned 0 aft=
er 0 usecs
<7>[    0.492444] calling  xts_module_init+0x0/0x11 @ 1
<7>[    0.492444] initcall xts_module_init+0x0/0x11 returned 0 after 0 us=
ecs
<7>[    0.492444] calling  crypto_ctr_module_init+0x0/0x16 @ 1
<7>[    0.492444] initcall crypto_ctr_module_init+0x0/0x16 returned 0 aft=
er 0 usecs
<7>[    0.492444] calling  crypto_gcm_module_init+0x0/0x65 @ 1
<7>[    0.492444] initcall crypto_gcm_module_init+0x0/0x65 returned 0 aft=
er 0 usecs
<7>[    0.492444] calling  crypto_ccm_module_init+0x0/0x16 @ 1
<7>[    0.492444] initcall crypto_ccm_module_init+0x0/0x16 returned 0 aft=
er 0 usecs
<7>[    0.492444] calling  des_generic_mod_init+0x0/0x16 @ 1
<7>[    0.492444] initcall des_generic_mod_init+0x0/0x16 returned 0 after=
 0 usecs
<7>[    0.492444] calling  blowfish_mod_init+0x0/0x11 @ 1
<7>[    0.492444] initcall blowfish_mod_init+0x0/0x11 returned 0 after 0 =
usecs
<7>[    0.492444] calling  aes_init+0x0/0x11 @ 1
<7>[    0.492444] initcall aes_init+0x0/0x11 returned 0 after 0 usecs
<7>[    0.492444] calling  camellia_init+0x0/0x11 @ 1
<7>[    0.492444] initcall camellia_init+0x0/0x11 returned 0 after 0 usec=
s
<7>[    0.492444] calling  cast5_mod_init+0x0/0x11 @ 1
<7>[    0.492444] initcall cast5_mod_init+0x0/0x11 returned 0 after 0 use=
cs
<7>[    0.492444] calling  cast6_mod_init+0x0/0x11 @ 1
<7>[    0.492444] initcall cast6_mod_init+0x0/0x11 returned 0 after 0 use=
cs
<7>[    0.492444] calling  arc4_init+0x0/0x11 @ 1
<7>[    0.492444] initcall arc4_init+0x0/0x11 returned 0 after 0 usecs
<7>[    0.492444] calling  deflate_mod_init+0x0/0x3f @ 1
<7>[    0.492444] initcall deflate_mod_init+0x0/0x3f returned 0 after 0 u=
secs
<7>[    0.492444] calling  michael_mic_init+0x0/0x11 @ 1
<6>[    0.492444] cryptomgr_test (57) used greatest stack depth: 15368 by=
tes left
<7>[    0.492444] initcall michael_mic_init+0x0/0x11 returned 0 after 0 u=
secs
<7>[    0.492444] calling  crc32c_mod_init+0x0/0x11 @ 1
<7>[    0.493402] initcall crc32c_mod_init+0x0/0x11 returned 0 after 976 =
usecs
<7>[    0.493402] calling  crypto_authenc_module_init+0x0/0x11 @ 1
<7>[    0.493402] initcall crypto_authenc_module_init+0x0/0x11 returned 0=
 after 0 usecs
<7>[    0.493402] calling  crypto_authenc_esn_module_init+0x0/0x11 @ 1
<7>[    0.493402] initcall crypto_authenc_esn_module_init+0x0/0x11 return=
ed 0 after 0 usecs
<7>[    0.493404] calling  drbg_init+0x0/0xca @ 1
<7>[    0.493422] initcall drbg_init+0x0/0xca returned 0 after 0 usecs
<7>[    0.493422] calling  ghash_mod_init+0x0/0x11 @ 1
<7>[    0.493422] initcall ghash_mod_init+0x0/0x11 returned 0 after 0 use=
cs
<7>[    0.493422] calling  init_bio+0x0/0xaa @ 1
<7>[    0.493422] initcall init_bio+0x0/0xaa returned 0 after 0 usecs
<7>[    0.493422] calling  blk_settings_init+0x0/0x2a @ 1
<7>[    0.493422] initcall blk_settings_init+0x0/0x2a returned 0 after 0 =
usecs
<7>[    0.493422] calling  blk_ioc_init+0x0/0x2a @ 1
<7>[    0.493422] initcall blk_ioc_init+0x0/0x2a returned 0 after 0 usecs=

<7>[    0.493423] calling  blk_mq_init+0x0/0xba @ 1
<7>[    0.493427] initcall blk_mq_init+0x0/0xba returned 0 after 0 usecs
<7>[    0.493429] calling  genhd_device_init+0x0/0x76 @ 1
<7>[    0.493464] initcall genhd_device_init+0x0/0x76 returned 0 after 0 =
usecs
<7>[    0.493464] calling  gpiolib_debugfs_init+0x0/0x24 @ 1
<7>[    0.493464] initcall gpiolib_debugfs_init+0x0/0x24 returned 0 after=
 0 usecs
<7>[    0.493464] calling  pci_slot_init+0x0/0x40 @ 1
<7>[    0.493464] initcall pci_slot_init+0x0/0x40 returned 0 after 0 usec=
s
<7>[    0.493464] calling  fbmem_init+0x0/0xdb @ 1
<7>[    0.493464] initcall fbmem_init+0x0/0xdb returned 0 after 0 usecs
<7>[    0.493464] calling  acpi_init+0x0/0x30a @ 1
<6>[    0.493479] ACPI: Added _OSI(Module Device)
<6>[    0.493483] ACPI: Added _OSI(Processor Device)
<6>[    0.493486] ACPI: Added _OSI(3.0 _SCP Extensions)
<6>[    0.493490] ACPI: Added _OSI(Processor Aggregator Device)
<6>[    0.493493] ACPI: Added _OSI(Linux-Dell-Video)
<6>[    0.493497] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
<6>[    0.493500] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
<6>[    0.569724] ACPI: 10 ACPI AML tables successfully acquired and load=
ed
<6>[    0.572019] ACPI: EC: EC started
<6>[    0.572022] ACPI: EC: interrupt blocked
<6>[    0.575677] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
<6>[    0.575681] ACPI: EC: Boot ECDT EC used to handle transactions
<5>[    0.578582] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
<6>[    0.590766] ACPI: Dynamic OEM Table Load:
<6>[    0.590792] ACPI: SSDT 0xFFFF9B6B43946000 0006F6 (v02 PmRef  Cpu0Is=
t  00003000 INTL 20160527)
<6>[    0.593373] ACPI: \_PR_.PR00: _OSC native thermal LVT Acked
<6>[    0.595097] ACPI: Dynamic OEM Table Load:
<6>[    0.595115] ACPI: SSDT 0xFFFF9B6B4398BC00 0003FF (v02 PmRef  Cpu0Cs=
t  00003001 INTL 20160527)
<6>[    0.597649] ACPI: Dynamic OEM Table Load:
<6>[    0.597664] ACPI: SSDT 0xFFFF9B6B434D56C0 0000BA (v02 PmRef  Cpu0Hw=
p  00003000 INTL 20160527)
<6>[    0.600039] ACPI: Dynamic OEM Table Load:
<6>[    0.600054] ACPI: SSDT 0xFFFF9B6B43946800 000628 (v02 PmRef  HwpLvt=
   00003000 INTL 20160527)
<6>[    0.603013] ACPI: Dynamic OEM Table Load:
<6>[    0.603033] ACPI: SSDT 0xFFFF9B6B43508000 000D14 (v02 PmRef  ApIst =
   00003000 INTL 20160527)
<6>[    0.606500] ACPI: Dynamic OEM Table Load:
<6>[    0.606515] ACPI: SSDT 0xFFFF9B6B43504000 000317 (v02 PmRef  ApHwp =
   00003000 INTL 20160527)
<6>[    0.609104] ACPI: Dynamic OEM Table Load:
<6>[    0.609118] ACPI: SSDT 0xFFFF9B6B43504400 00030A (v02 PmRef  ApCst =
   00003000 INTL 20160527)
<6>[    0.613591] ACPI: Interpreter enabled
<6>[    0.613665] ACPI: (supports S0 S3 S5)
<6>[    0.613669] ACPI: Using IOAPIC for interrupt routing
<6>[    0.613735] PCI: Using host bridge windows from ACPI; if necessary,=
 use "pci=3Dnocrs" and report a bug
<6>[    0.614799] ACPI: Enabled 7 GPEs in block 00 to 7F
<6>[    0.620579] ACPI: Power Resource [PUBS] (on)
<6>[    0.639344] ACPI: Power Resource [WRST] (on)
<6>[    0.641015] ACPI: Power Resource [WRST] (on)
<6>[    0.660566] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
<6>[    0.660579] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM=
 ClockPM Segments MSI HPX-Type3]
<6>[    0.660792] acpi PNP0A08:00: _OSC: platform does not support [PCIeH=
otplug SHPCHotplug PME PCIeCapability]
<6>[    0.660891] acpi PNP0A08:00: _OSC: not requesting control; platform=
 does not support [PCIeCapability]
<6>[    0.660898] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug SHPCHo=
tplug PME PCIeCapability LTR]
<6>[    0.660902] acpi PNP0A08:00: _OSC: platform willing to grant [LTR]
<6>[    0.660906] acpi PNP0A08:00: _OSC failed (AE_SUPPORT); disabling AS=
PM
<6>[    0.662933] PCI host bridge to bus 0000:00
<6>[    0.662940] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 w=
indow]
<6>[    0.662945] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff w=
indow]
<6>[    0.662949] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x00=
0bffff window]
<6>[    0.662954] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x00=
0c3fff window]
<6>[    0.662958] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x00=
0c7fff window]
<6>[    0.662962] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x00=
0cbfff window]
<6>[    0.662966] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x00=
0cffff window]
<6>[    0.662970] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x00=
0d3fff window]
<6>[    0.662975] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x00=
0d7fff window]
<6>[    0.662979] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x00=
0dbfff window]
<6>[    0.662983] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x00=
0dffff window]
<6>[    0.662987] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x00=
0e3fff window]
<6>[    0.662992] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x00=
0e7fff window]
<6>[    0.662996] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x00=
0ebfff window]
<6>[    0.663000] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x00=
0effff window]
<6>[    0.663004] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x00=
0fffff window]
<6>[    0.663009] pci_bus 0000:00: root bus resource [mem 0x9f800000-0xf7=
ffffff window]
<6>[    0.663013] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe=
7fffff window]
<6>[    0.663017] pci_bus 0000:00: root bus resource [bus 00-3e]
<6>[    0.663046] pci 0000:00:00.0: calling  quirk_mmio_always_on+0x0/0x1=
0 @ 1
<6>[    0.663053] pci 0000:00:00.0: quirk_mmio_always_on+0x0/0x10 took 0 =
usecs
<6>[    0.663059] pci 0000:00:00.0: [8086:5904] type 00 class 0x060000
<6>[    0.663108] pci 0000:00:00.0: calling  quirk_igfx_skip_te_disable+0=
x0/0x50 @ 1
<6>[    0.663115] pci 0000:00:00.0: quirk_igfx_skip_te_disable+0x0/0x50 t=
ook 0 usecs
<6>[    0.664427] pci 0000:00:02.0: [8086:5916] type 00 class 0x030000
<6>[    0.664447] pci 0000:00:02.0: reg 0x10: [mem 0xeb000000-0xebffffff =
64bit]
<6>[    0.664460] pci 0000:00:02.0: reg 0x18: [mem 0xa0000000-0xafffffff =
64bit pref]
<6>[    0.664470] pci 0000:00:02.0: reg 0x20: [io  0xe000-0xe03f]
<6>[    0.664504] pci 0000:00:02.0: calling  efifb_fixup_resources+0x0/0x=
f0 @ 1
<6>[    0.664510] pci 0000:00:02.0: BAR 2: assigned to efifb
<6>[    0.664515] pci 0000:00:02.0: efifb_fixup_resources+0x0/0xf0 took 0=
 usecs
<6>[    0.664522] pci 0000:00:02.0: calling  quirk_igfx_skip_te_disable+0=
x0/0x50 @ 1
<6>[    0.664529] pci 0000:00:02.0: quirk_igfx_skip_te_disable+0x0/0x50 t=
ook 0 usecs
<6>[    0.665962] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
<6>[    0.665992] pci 0000:00:14.0: reg 0x10: [mem 0xec220000-0xec22ffff =
64bit]
<6>[    0.666053] pci 0000:00:14.0: calling  quirk_igfx_skip_te_disable+0=
x0/0x50 @ 1
<6>[    0.666060] pci 0000:00:14.0: quirk_igfx_skip_te_disable+0x0/0x50 t=
ook 0 usecs
<6>[    0.666100] pci 0000:00:14.0: PME# supported from D3hot D3cold
<6>[    0.667604] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
<6>[    0.667635] pci 0000:00:14.2: reg 0x10: [mem 0xec248000-0xec248fff =
64bit]
<6>[    0.667700] pci 0000:00:14.2: calling  quirk_igfx_skip_te_disable+0=
x0/0x50 @ 1
<6>[    0.667707] pci 0000:00:14.2: quirk_igfx_skip_te_disable+0x0/0x50 t=
ook 0 usecs
<6>[    0.669062] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
<6>[    0.669093] pci 0000:00:16.0: reg 0x10: [mem 0xec249000-0xec249fff =
64bit]
<6>[    0.669148] pci 0000:00:16.0: calling  quirk_igfx_skip_te_disable+0=
x0/0x50 @ 1
<6>[    0.669155] pci 0000:00:16.0: quirk_igfx_skip_te_disable+0x0/0x50 t=
ook 0 usecs
<6>[    0.669206] pci 0000:00:16.0: PME# supported from D3hot
<6>[    0.670668] pci 0000:00:1c.0: calling  quirk_cmd_compl+0x0/0x70 @ 1=

<6>[    0.670676] pci 0000:00:1c.0: quirk_cmd_compl+0x0/0x70 took 0 usecs=

<6>[    0.670684] pci 0000:00:1c.0: calling  quirk_no_aersid+0x0/0x10 @ 1=

<6>[    0.670690] pci 0000:00:1c.0: quirk_no_aersid+0x0/0x10 took 0 usecs=

<6>[    0.670694] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
<6>[    0.670767] pci 0000:00:1c.0: calling  quirk_igfx_skip_te_disable+0=
x0/0x50 @ 1
<6>[    0.670774] pci 0000:00:1c.0: quirk_igfx_skip_te_disable+0x0/0x50 t=
ook 0 usecs
<6>[    0.670780] pci 0000:00:1c.0: calling  pci_fixup_transparent_bridge=
+0x0/0x20 @ 1
<6>[    0.670787] pci 0000:00:1c.0: pci_fixup_transparent_bridge+0x0/0x20=
 took 0 usecs
<6>[    0.670843] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
<6>[    0.670869] pci 0000:00:1c.0: Intel SPT PCH root port ACS workaroun=
d enabled
<6>[    0.672299] pci 0000:00:1c.2: calling  quirk_cmd_compl+0x0/0x70 @ 1=

<6>[    0.672311] pci 0000:00:1c.2: quirk_cmd_compl+0x0/0x70 took 0 usecs=

<6>[    0.672317] pci 0000:00:1c.2: calling  quirk_no_aersid+0x0/0x10 @ 1=

<6>[    0.672322] pci 0000:00:1c.2: quirk_no_aersid+0x0/0x10 took 0 usecs=

<6>[    0.672326] pci 0000:00:1c.2: [8086:9d12] type 01 class 0x060400
<6>[    0.672398] pci 0000:00:1c.2: calling  quirk_igfx_skip_te_disable+0=
x0/0x50 @ 1
<6>[    0.672405] pci 0000:00:1c.2: quirk_igfx_skip_te_disable+0x0/0x50 t=
ook 0 usecs
<6>[    0.672411] pci 0000:00:1c.2: calling  pci_fixup_transparent_bridge=
+0x0/0x20 @ 1
<6>[    0.672418] pci 0000:00:1c.2: pci_fixup_transparent_bridge+0x0/0x20=
 took 0 usecs
<6>[    0.672476] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
<6>[    0.672503] pci 0000:00:1c.2: Intel SPT PCH root port ACS workaroun=
d enabled
<6>[    0.673945] pci 0000:00:1d.0: calling  quirk_cmd_compl+0x0/0x70 @ 1=

<6>[    0.673963] pci 0000:00:1d.0: quirk_cmd_compl+0x0/0x70 took 0 usecs=

<6>[    0.673969] pci 0000:00:1d.0: calling  quirk_no_aersid+0x0/0x10 @ 1=

<6>[    0.673974] pci 0000:00:1d.0: quirk_no_aersid+0x0/0x10 took 0 usecs=

<6>[    0.673978] pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400
<6>[    0.674059] pci 0000:00:1d.0: calling  quirk_igfx_skip_te_disable+0=
x0/0x50 @ 1
<6>[    0.674065] pci 0000:00:1d.0: quirk_igfx_skip_te_disable+0x0/0x50 t=
ook 0 usecs
<6>[    0.674072] pci 0000:00:1d.0: calling  pci_fixup_transparent_bridge=
+0x0/0x20 @ 1
<6>[    0.674078] pci 0000:00:1d.0: pci_fixup_transparent_bridge+0x0/0x20=
 took 0 usecs
<6>[    0.674143] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
<6>[    0.674183] pci 0000:00:1d.0: Intel SPT PCH root port ACS workaroun=
d enabled
<6>[    0.675634] pci 0000:00:1f.0: [8086:9d58] type 00 class 0x060100
<6>[    0.675765] pci 0000:00:1f.0: calling  quirk_igfx_skip_te_disable+0=
x0/0x50 @ 1
<6>[    0.675772] pci 0000:00:1f.0: quirk_igfx_skip_te_disable+0x0/0x50 t=
ook 0 usecs
<6>[    0.677180] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
<6>[    0.677202] pci 0000:00:1f.2: reg 0x10: [mem 0xec244000-0xec247fff]=

<6>[    0.677265] pci 0000:00:1f.2: calling  quirk_igfx_skip_te_disable+0=
x0/0x50 @ 1
<6>[    0.677272] pci 0000:00:1f.2: quirk_igfx_skip_te_disable+0x0/0x50 t=
ook 0 usecs
<6>[    0.678678] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040300
<6>[    0.678713] pci 0000:00:1f.3: reg 0x10: [mem 0xec240000-0xec243fff =
64bit]
<6>[    0.678760] pci 0000:00:1f.3: reg 0x20: [mem 0xec230000-0xec23ffff =
64bit]
<6>[    0.678790] pci 0000:00:1f.3: calling  quirk_igfx_skip_te_disable+0=
x0/0x50 @ 1
<6>[    0.678797] pci 0000:00:1f.3: quirk_igfx_skip_te_disable+0x0/0x50 t=
ook 0 usecs
<6>[    0.678849] pci 0000:00:1f.3: PME# supported from D3hot D3cold
<6>[    0.680287] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
<6>[    0.680344] pci 0000:00:1f.4: reg 0x10: [mem 0xec24a000-0xec24a0ff =
64bit]
<6>[    0.680402] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
<6>[    0.680459] pci 0000:00:1f.4: calling  quirk_igfx_skip_te_disable+0=
x0/0x50 @ 1
<6>[    0.680466] pci 0000:00:1f.4: quirk_igfx_skip_te_disable+0x0/0x50 t=
ook 0 usecs
<6>[    0.681897] pci 0000:00:1f.6: calling  quirk_f0_vpd_link+0x0/0x60 @=
 1
<6>[    0.681904] pci 0000:00:1f.6: quirk_f0_vpd_link+0x0/0x60 took 0 use=
cs
<6>[    0.681910] pci 0000:00:1f.6: [8086:15d8] type 00 class 0x020000
<6>[    0.681939] pci 0000:00:1f.6: reg 0x10: [mem 0xec200000-0xec21ffff]=

<6>[    0.682024] pci 0000:00:1f.6: calling  quirk_igfx_skip_te_disable+0=
x0/0x50 @ 1
<6>[    0.682031] pci 0000:00:1f.6: quirk_igfx_skip_te_disable+0x0/0x50 t=
ook 0 usecs
<6>[    0.682088] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
<6>[    0.683559] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
<6>[    0.683570] pci 0000:00:1c.0:   bridge window [mem 0xd4000000-0xea0=
fffff]
<6>[    0.683581] pci 0000:00:1c.0:   bridge window [mem 0xb0000000-0xd1f=
fffff 64bit pref]
<6>[    0.684137] pci 0000:3a:00.0: [8086:24fd] type 00 class 0x028000
<6>[    0.684227] pci 0000:3a:00.0: reg 0x10: [mem 0xec100000-0xec101fff =
64bit]
<6>[    0.684461] pci 0000:3a:00.0: calling  quirk_igfx_skip_te_disable+0=
x0/0x50 @ 1
<6>[    0.684468] pci 0000:3a:00.0: quirk_igfx_skip_te_disable+0x0/0x50 t=
ook 0 usecs
<6>[    0.684890] pci 0000:3a:00.0: PME# supported from D0 D3hot D3cold
<6>[    0.685595] pci 0000:00:1c.2: PCI bridge to [bus 3a]
<6>[    0.685607] pci 0000:00:1c.2:   bridge window [mem 0xec100000-0xec1=
fffff]
<6>[    0.685945] pci 0000:3c:00.0: [144d:a804] type 00 class 0x010802
<6>[    0.685973] pci 0000:3c:00.0: reg 0x10: [mem 0xec000000-0xec003fff =
64bit]
<6>[    0.686428] pci 0000:00:1d.0: PCI bridge to [bus 3c]
<6>[    0.686437] pci 0000:00:1d.0:   bridge window [mem 0xec000000-0xec0=
fffff]
<6>[    0.689279] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12=
 14 15)
<6>[    0.689374] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12=
 14 15)
<6>[    0.689459] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12=
 14 15)
<6>[    0.689545] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12=
 14 15)
<6>[    0.689631] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12=
 14 15)
<6>[    0.689717] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12=
 14 15)
<6>[    0.689802] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12=
 14 15)
<6>[    0.689889] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12=
 14 15)
<6>[    0.690742] ACPI: EC: interrupt unblocked
<6>[    0.690746] ACPI: EC: event unblocked
<6>[    0.690765] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
<6>[    0.690768] ACPI: EC: GPE=3D0x16
<6>[    0.690773] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization=
 complete
<6>[    0.690777] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transact=
ions and events
<7>[    0.690878] initcall acpi_init+0x0/0x30a returned 0 after 192382 us=
ecs
<7>[    0.690882] calling  pnp_init+0x0/0x11 @ 1
<7>[    0.690892] initcall pnp_init+0x0/0x11 returned 0 after 0 usecs
<7>[    0.690895] calling  misc_init+0x0/0xbf @ 1
<7>[    0.690903] initcall misc_init+0x0/0xbf returned 0 after 0 usecs
<7>[    0.690906] calling  iommu_subsys_init+0x0/0x4f @ 1
<6>[    0.690907] iommu: Default domain type: Translated=20
<7>[    0.690913] initcall iommu_subsys_init+0x0/0x4f returned 0 after 0 =
usecs
<7>[    0.690917] calling  cn_init+0x0/0xf0 @ 1
<7>[    0.690927] initcall cn_init+0x0/0xf0 returned 0 after 0 usecs
<7>[    0.690930] calling  dax_core_init+0x0/0xb9 @ 1
<7>[    0.690960] initcall dax_core_init+0x0/0xb9 returned 0 after 0 usec=
s
<7>[    0.690963] calling  dma_buf_init+0x0/0xc9 @ 1
<7>[    0.690974] initcall dma_buf_init+0x0/0xc9 returned 0 after 0 usecs=

<7>[    0.690976] calling  init_scsi+0x0/0x7a @ 1
<5>[    0.691033] SCSI subsystem initialized
<7>[    0.691038] initcall init_scsi+0x0/0x7a returned 0 after 0 usecs
<7>[    0.691041] calling  ata_init+0x0/0x324 @ 1
<7>[    0.691105] libata version 3.00 loaded.
<7>[    0.691109] initcall ata_init+0x0/0x324 returned 0 after 0 usecs
<7>[    0.691112] calling  phy_init+0x0/0x2bd @ 1
<7>[    0.691133] initcall phy_init+0x0/0x2bd returned 0 after 0 usecs
<7>[    0.691136] calling  init_pcmcia_cs+0x0/0x3c @ 1
<7>[    0.691142] initcall init_pcmcia_cs+0x0/0x3c returned 0 after 0 use=
cs
<7>[    0.691145] calling  usb_common_init+0x0/0x1d @ 1
<7>[    0.691150] initcall usb_common_init+0x0/0x1d returned 0 after 0 us=
ecs
<7>[    0.691153] calling  usb_init+0x0/0x129 @ 1
<6>[    0.691156] ACPI: bus type USB registered
<6>[    0.691180] usbcore: registered new interface driver usbfs
<6>[    0.691191] usbcore: registered new interface driver hub
<6>[    0.691220] usbcore: registered new device driver usb
<7>[    0.691226] initcall usb_init+0x0/0x129 returned 0 after 0 usecs
<7>[    0.691229] calling  typec_init+0x0/0x73 @ 1
<7>[    0.691245] initcall typec_init+0x0/0x73 returned 0 after 0 usecs
<7>[    0.691248] calling  serio_init+0x0/0x2a @ 1
<7>[    0.691258] initcall serio_init+0x0/0x2a returned 0 after 0 usecs
<7>[    0.691261] calling  input_init+0x0/0xfd @ 1
<7>[    0.691273] initcall input_init+0x0/0xfd returned 0 after 0 usecs
<7>[    0.691275] calling  rtc_init+0x0/0x4c @ 1
<7>[    0.691286] initcall rtc_init+0x0/0x4c returned 0 after 0 usecs
<7>[    0.691287] calling  pps_init+0x0/0xaa @ 1
<6>[    0.691291] pps_core: LinuxPPS API ver. 1 registered
<6>[    0.691294] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rod=
olfo Giometti <giometti@linux.it>
<7>[    0.691299] initcall pps_init+0x0/0xaa returned 0 after 0 usecs
<7>[    0.691301] calling  ptp_init+0x0/0x99 @ 1
<6>[    0.691304] PTP clock support registered
<7>[    0.691308] initcall ptp_init+0x0/0x99 returned 0 after 0 usecs
<7>[    0.691310] calling  power_supply_class_init+0x0/0x40 @ 1
<7>[    0.691319] initcall power_supply_class_init+0x0/0x40 returned 0 af=
ter 0 usecs
<7>[    0.691321] calling  hwmon_init+0x0/0xf9 @ 1
<7>[    0.691328] initcall hwmon_init+0x0/0xf9 returned 0 after 0 usecs
<7>[    0.691330] calling  leds_init+0x0/0x3c @ 1
<7>[    0.691335] initcall leds_init+0x0/0x3c returned 0 after 0 usecs
<7>[    0.691336] calling  dmi_init+0x0/0x114 @ 1
<7>[    0.691348] initcall dmi_init+0x0/0x114 returned 0 after 0 usecs
<7>[    0.691351] calling  efisubsys_init+0x0/0x514 @ 1
<6>[    0.691376] Registered efivars operations
<7>[    0.691405] initcall efisubsys_init+0x0/0x514 returned 0 after 976 =
usecs
<7>[    0.691408] calling  nvmem_init+0x0/0x11 @ 1
<7>[    0.691417] initcall nvmem_init+0x0/0x11 returned 0 after 0 usecs
<7>[    0.691420] calling  init_soundcore+0x0/0x34 @ 1
<7>[    0.691425] initcall init_soundcore+0x0/0x34 returned 0 after 0 use=
cs
<7>[    0.691428] calling  alsa_sound_init+0x0/0x90 @ 1
<6>[    0.691436] Advanced Linux Sound Architecture Driver Initialized.
<7>[    0.691441] initcall alsa_sound_init+0x0/0x90 returned 0 after 0 us=
ecs
<7>[    0.691444] calling  alsa_seq_device_init+0x0/0x72 @ 1
<7>[    0.691453] initcall alsa_seq_device_init+0x0/0x72 returned 0 after=
 0 usecs
<7>[    0.691456] calling  hda_bus_init+0x0/0x11 @ 1
<7>[    0.691466] initcall hda_bus_init+0x0/0x11 returned 0 after 0 usecs=

<7>[    0.691469] calling  ac97_bus_init+0x0/0x11 @ 1
<7>[    0.691477] initcall ac97_bus_init+0x0/0x11 returned 0 after 0 usec=
s
<7>[    0.691480] calling  proto_init+0x0/0x11 @ 1
<7>[    0.691485] initcall proto_init+0x0/0x11 returned 0 after 0 usecs
<7>[    0.691488] calling  net_dev_init+0x0/0x226 @ 1
<7>[    0.691594] initcall net_dev_init+0x0/0x226 returned 0 after 0 usec=
s
<7>[    0.691597] calling  neigh_init+0x0/0x85 @ 1
<7>[    0.691602] initcall neigh_init+0x0/0x85 returned 0 after 0 usecs
<7>[    0.691605] calling  fib_notifier_init+0x0/0x11 @ 1
<7>[    0.691609] initcall fib_notifier_init+0x0/0x11 returned 0 after 0 =
usecs
<7>[    0.691612] calling  fib_rules_init+0x0/0xac @ 1
<7>[    0.691617] initcall fib_rules_init+0x0/0xac returned 0 after 0 use=
cs
<7>[    0.691620] calling  pktsched_init+0x0/0x10f @ 1
<7>[    0.691628] initcall pktsched_init+0x0/0x10f returned 0 after 0 use=
cs
<7>[    0.691631] calling  tc_filter_init+0x0/0xfb @ 1
<7>[    0.691639] initcall tc_filter_init+0x0/0xfb returned 0 after 0 use=
cs
<7>[    0.691642] calling  tc_action_init+0x0/0x55 @ 1
<7>[    0.691646] initcall tc_action_init+0x0/0x55 returned 0 after 0 use=
cs
<7>[    0.691649] calling  ethnl_init+0x0/0x53 @ 1
<7>[    0.691669] initcall ethnl_init+0x0/0x53 returned 0 after 0 usecs
<7>[    0.691672] calling  nexthop_init+0x0/0xd9 @ 1
<7>[    0.691676] initcall nexthop_init+0x0/0xd9 returned 0 after 0 usecs=

<7>[    0.691679] calling  wireless_nlevent_init+0x0/0x3a @ 1
<7>[    0.691683] initcall wireless_nlevent_init+0x0/0x3a returned 0 afte=
r 0 usecs
<7>[    0.691685] calling  ieee80211_init+0x0/0x25 @ 1
<7>[    0.691696] initcall ieee80211_init+0x0/0x25 returned 0 after 0 use=
cs
<7>[    0.691698] calling  rfkill_init+0x0/0x111 @ 1
<7>[    0.691722] initcall rfkill_init+0x0/0x111 returned 0 after 0 usecs=

<7>[    0.691722] calling  pci_subsys_init+0x0/0x67 @ 1
<6>[    0.691722] PCI: Using ACPI for IRQ routing
<7>[    0.694556] PCI: pci_cache_line_size set to 64 bytes
<7>[    0.695642] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
<7>[    0.695644] e820: reserve RAM buffer [mem 0x0009d000-0x0009ffff]
<7>[    0.695645] e820: reserve RAM buffer [mem 0x90b6d000-0x93ffffff]
<7>[    0.695647] e820: reserve RAM buffer [mem 0x94dcc000-0x97ffffff]
<7>[    0.695648] e820: reserve RAM buffer [mem 0x9a4ac000-0x9bffffff]
<7>[    0.695650] e820: reserve RAM buffer [mem 0x9b600000-0x9bffffff]
<7>[    0.695652] e820: reserve RAM buffer [mem 0x65f800000-0x65fffffff]
<7>[    0.695656] initcall pci_subsys_init+0x0/0x67 returned 0 after 3906=
 usecs
<7>[    0.695659] calling  acpi_wmi_init+0x0/0x7b @ 1
<4>[    0.696018] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-=
B2F0-00A0C9062910 (first instance was on PNP0C14:01)
<4>[    0.696128] acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-=
B2F0-00A0C9062910 (first instance was on PNP0C14:01)
<7>[    0.696173] initcall acpi_wmi_init+0x0/0x7b returned 0 after 0 usec=
s
<7>[    0.696320] calling  nmi_warning_debugfs+0x0/0x27 @ 1
<7>[    0.696326] initcall nmi_warning_debugfs+0x0/0x27 returned 0 after =
0 usecs
<7>[    0.696330] calling  save_microcode_in_initrd+0x0/0x52 @ 1
<7>[    0.697308] initcall save_microcode_in_initrd+0x0/0x52 returned 0 a=
fter 976 usecs
<7>[    0.697311] calling  hpet_late_init+0x0/0x1cf @ 1
<7>[    0.697315] initcall hpet_late_init+0x0/0x1cf returned 0 after 0 us=
ecs
<7>[    0.697318] calling  init_amd_nbs+0x0/0x11f @ 1
<7>[    0.697328] initcall init_amd_nbs+0x0/0x11f returned 0 after 0 usec=
s
<7>[    0.697331] calling  clocksource_done_booting+0x0/0x42 @ 1
<6>[    0.697347] clocksource: Switched to clocksource tsc-early
<7>[    0.697353] initcall clocksource_done_booting+0x0/0x42 returned 0 a=
fter 8 usecs
<7>[    0.697356] calling  tracer_init_tracefs+0x0/0x1cd @ 1
<7>[    0.718129] initcall tracer_init_tracefs+0x0/0x1cd returned 0 after=
 21211 usecs
<7>[    0.718134] calling  init_trace_printk_function_export+0x0/0x2d @ 1=

<7>[    0.718139] initcall init_trace_printk_function_export+0x0/0x2d ret=
urned 0 after 1 usecs
<7>[    0.718142] calling  init_graph_tracefs+0x0/0x2d @ 1
<7>[    0.718146] initcall init_graph_tracefs+0x0/0x2d returned 0 after 1=
 usecs
<7>[    0.718148] calling  bpf_event_init+0x0/0xf @ 1
<7>[    0.718150] initcall bpf_event_init+0x0/0xf returned 0 after 0 usec=
s
<7>[    0.718152] calling  init_kprobe_trace+0x0/0x188 @ 1
<7>[    0.718161] initcall init_kprobe_trace+0x0/0x188 returned 0 after 6=
 usecs
<7>[    0.718163] calling  init_dynamic_event+0x0/0x3e @ 1
<7>[    0.718167] initcall init_dynamic_event+0x0/0x3e returned 0 after 2=
 usecs
<7>[    0.718169] calling  init_uprobe_trace+0x0/0x63 @ 1
<7>[    0.718177] initcall init_uprobe_trace+0x0/0x63 returned 0 after 5 =
usecs
<7>[    0.718179] calling  bpf_init+0x0/0x48 @ 1
<7>[    0.718184] initcall bpf_init+0x0/0x48 returned 0 after 3 usecs
<7>[    0.718187] calling  init_pipe_fs+0x0/0x45 @ 1
<7>[    0.718199] initcall init_pipe_fs+0x0/0x45 returned 0 after 9 usecs=

<7>[    0.718202] calling  inotify_user_setup+0x0/0x48 @ 1
<7>[    0.718208] initcall inotify_user_setup+0x0/0x48 returned 0 after 2=
 usecs
<7>[    0.718211] calling  eventpoll_init+0x0/0xc9 @ 1
<7>[    0.718216] initcall eventpoll_init+0x0/0xc9 returned 0 after 2 use=
cs
<7>[    0.718219] calling  anon_inode_init+0x0/0x59 @ 1
<7>[    0.718230] initcall anon_inode_init+0x0/0x59 returned 0 after 7 us=
ecs
<7>[    0.718233] calling  proc_locks_init+0x0/0x28 @ 1
<7>[    0.718237] initcall proc_locks_init+0x0/0x28 returned 0 after 1 us=
ecs
<7>[    0.718240] calling  iomap_init+0x0/0x20 @ 1
<7>[    0.718257] initcall iomap_init+0x0/0x20 returned 0 after 13 usecs
<7>[    0.718260] calling  proc_cmdline_init+0x0/0x22 @ 1
<7>[    0.718265] initcall proc_cmdline_init+0x0/0x22 returned 0 after 1 =
usecs
<7>[    0.718268] calling  proc_consoles_init+0x0/0x25 @ 1
<7>[    0.718272] initcall proc_consoles_init+0x0/0x25 returned 0 after 0=
 usecs
<7>[    0.718275] calling  proc_cpuinfo_init+0x0/0x1f @ 1
<7>[    0.718279] initcall proc_cpuinfo_init+0x0/0x1f returned 0 after 1 =
usecs
<7>[    0.718282] calling  proc_devices_init+0x0/0x25 @ 1
<7>[    0.718286] initcall proc_devices_init+0x0/0x25 returned 0 after 0 =
usecs
<7>[    0.718289] calling  proc_interrupts_init+0x0/0x25 @ 1
<7>[    0.718293] initcall proc_interrupts_init+0x0/0x25 returned 0 after=
 0 usecs
<7>[    0.718296] calling  proc_loadavg_init+0x0/0x22 @ 1
<7>[    0.718300] initcall proc_loadavg_init+0x0/0x22 returned 0 after 0 =
usecs
<7>[    0.718303] calling  proc_meminfo_init+0x0/0x22 @ 1
<7>[    0.718306] initcall proc_meminfo_init+0x0/0x22 returned 0 after 0 =
usecs
<7>[    0.718309] calling  proc_stat_init+0x0/0x1f @ 1
<7>[    0.718313] initcall proc_stat_init+0x0/0x1f returned 0 after 0 use=
cs
<7>[    0.718316] calling  proc_uptime_init+0x0/0x22 @ 1
<7>[    0.718320] initcall proc_uptime_init+0x0/0x22 returned 0 after 0 u=
secs
<7>[    0.718323] calling  proc_version_init+0x0/0x22 @ 1
<7>[    0.718327] initcall proc_version_init+0x0/0x22 returned 0 after 0 =
usecs
<7>[    0.718330] calling  proc_softirqs_init+0x0/0x22 @ 1
<7>[    0.718334] initcall proc_softirqs_init+0x0/0x22 returned 0 after 0=
 usecs
<7>[    0.718337] calling  proc_kmsg_init+0x0/0x22 @ 1
<7>[    0.718341] initcall proc_kmsg_init+0x0/0x22 returned 0 after 0 use=
cs
<7>[    0.718344] calling  proc_page_init+0x0/0x3c @ 1
<7>[    0.718349] initcall proc_page_init+0x0/0x3c returned 0 after 1 use=
cs
<7>[    0.718352] calling  init_ramfs_fs+0x0/0x11 @ 1
<7>[    0.718356] initcall init_ramfs_fs+0x0/0x11 returned 0 after 0 usec=
s
<7>[    0.718358] calling  blk_scsi_ioctl_init+0x0/0x3b3 @ 1
<7>[    0.718361] initcall blk_scsi_ioctl_init+0x0/0x3b3 returned 0 after=
 0 usecs
<7>[    0.718364] calling  dynamic_debug_init_control+0x0/0x77 @ 1
<7>[    0.718371] initcall dynamic_debug_init_control+0x0/0x77 returned 0=
 after 5 usecs
<7>[    0.718375] calling  acpi_event_init+0x0/0x2d @ 1
<7>[    0.718386] initcall acpi_event_init+0x0/0x2d returned 0 after 8 us=
ecs
<7>[    0.718388] calling  pnp_system_init+0x0/0x11 @ 1
<7>[    0.718403] initcall pnp_system_init+0x0/0x11 returned 0 after 9 us=
ecs
<7>[    0.718404] calling  pnpacpi_init+0x0/0x6a @ 1
<6>[    0.718405] pnp: PnP ACPI init
<6>[    0.718645] system 00:00: [mem 0xfd000000-0xfdabffff] has been rese=
rved
<6>[    0.718651] system 00:00: [mem 0xfdad0000-0xfdadffff] has been rese=
rved
<6>[    0.718656] system 00:00: [mem 0xfdb00000-0xfdffffff] has been rese=
rved
<6>[    0.718660] system 00:00: [mem 0xfe000000-0xfe01ffff] could not be =
reserved
<6>[    0.718665] system 00:00: [mem 0xfe036000-0xfe03bfff] has been rese=
rved
<6>[    0.718669] system 00:00: [mem 0xfe03d000-0xfe3fffff] has been rese=
rved
<6>[    0.718673] system 00:00: [mem 0xfe410000-0xfe7fffff] has been rese=
rved
<7>[    0.718683] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (a=
ctive)
<6>[    0.719189] system 00:01: [io  0xff00-0xfffe] has been reserved
<7>[    0.719198] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (a=
ctive)
<6>[    0.720026] system 00:02: [io  0x0680-0x069f] has been reserved
<6>[    0.720031] system 00:02: [io  0xffff] has been reserved
<6>[    0.720035] system 00:02: [io  0xffff] has been reserved
<6>[    0.720039] system 00:02: [io  0xffff] has been reserved
<6>[    0.720043] system 00:02: [io  0x1800-0x18fe] has been reserved
<6>[    0.720047] system 00:02: [io  0x164e-0x164f] has been reserved
<7>[    0.720055] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (a=
ctive)
<7>[    0.720221] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (acti=
ve)
<6>[    0.720280] system 00:04: [io  0x1854-0x1857] has been reserved
<7>[    0.720289] system 00:04: Plug and Play ACPI device, IDs INT3f0d PN=
P0c02 (active)
<7>[    0.720318] pnp 00:05: Plug and Play ACPI device, IDs LEN0071 PNP03=
03 (active)
<7>[    0.720343] pnp 00:06: Plug and Play ACPI device, IDs LEN006c PNP0f=
13 (active)
<6>[    0.720509] system 00:07: [io  0x1800-0x189f] could not be reserved=

<6>[    0.720515] system 00:07: [io  0x0800-0x087f] has been reserved
<6>[    0.720519] system 00:07: [io  0x0880-0x08ff] has been reserved
<6>[    0.720523] system 00:07: [io  0x0900-0x097f] has been reserved
<6>[    0.720527] system 00:07: [io  0x0980-0x09ff] has been reserved
<6>[    0.720531] system 00:07: [io  0x0a00-0x0a7f] has been reserved
<6>[    0.720535] system 00:07: [io  0x0a80-0x0aff] has been reserved
<6>[    0.720539] system 00:07: [io  0x0b00-0x0b7f] has been reserved
<6>[    0.720543] system 00:07: [io  0x0b80-0x0bff] has been reserved
<6>[    0.720547] system 00:07: [io  0x15e0-0x15ef] has been reserved
<6>[    0.720553] system 00:07: [io  0x1600-0x167f] could not be reserved=

<6>[    0.720557] system 00:07: [io  0x1640-0x165f] could not be reserved=

<6>[    0.720562] system 00:07: [mem 0xf8000000-0xfbffffff] has been rese=
rved
<6>[    0.720567] system 00:07: [mem 0xfed10000-0xfed13fff] has been rese=
rved
<6>[    0.720571] system 00:07: [mem 0xfed18000-0xfed18fff] has been rese=
rved
<6>[    0.720576] system 00:07: [mem 0xfed19000-0xfed19fff] has been rese=
rved
<6>[    0.720580] system 00:07: [mem 0xfeb00000-0xfebfffff] has been rese=
rved
<6>[    0.720584] system 00:07: [mem 0xfed20000-0xfed3ffff] has been rese=
rved
<6>[    0.720589] system 00:07: [mem 0xfed90000-0xfed93fff] has been rese=
rved
<6>[    0.720593] system 00:07: [mem 0xf7fe0000-0xf7ffffff] has been rese=
rved
<7>[    0.720601] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (a=
ctive)
<6>[    0.722656] system 00:08: [mem 0xfdaf0000-0xfdafffff] has been rese=
rved
<6>[    0.722662] system 00:08: [mem 0xfdae0000-0xfdaeffff] has been rese=
rved
<6>[    0.722666] system 00:08: [mem 0xfdac0000-0xfdacffff] has been rese=
rved
<7>[    0.722674] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (a=
ctive)
<6>[    0.723563] system 00:09: [mem 0xfed10000-0xfed17fff] could not be =
reserved
<6>[    0.723568] system 00:09: [mem 0xfed18000-0xfed18fff] has been rese=
rved
<6>[    0.723573] system 00:09: [mem 0xfed19000-0xfed19fff] has been rese=
rved
<6>[    0.723577] system 00:09: [mem 0xf8000000-0xfbffffff] has been rese=
rved
<6>[    0.723581] system 00:09: [mem 0xfed20000-0xfed3ffff] has been rese=
rved
<6>[    0.723586] system 00:09: [mem 0xfed90000-0xfed93fff] has been rese=
rved
<6>[    0.723590] system 00:09: [mem 0xfed45000-0xfed8ffff] has been rese=
rved
<6>[    0.723594] system 00:09: [mem 0xff000000-0xffffffff] has been rese=
rved
<6>[    0.723598] system 00:09: [mem 0xfee00000-0xfeefffff] has been rese=
rved
<6>[    0.723603] system 00:09: [mem 0xf7fe0000-0xf7ffffff] has been rese=
rved
<7>[    0.723611] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (a=
ctive)
<6>[    0.724032] system 00:0a: [mem 0x00000000-0x0009ffff] could not be =
reserved
<6>[    0.724038] system 00:0a: [mem 0x000f0000-0x000fffff] could not be =
reserved
<6>[    0.724042] system 00:0a: [mem 0x00100000-0x9f7fffff] could not be =
reserved
<6>[    0.724047] system 00:0a: [mem 0xfec00000-0xfed3ffff] could not be =
reserved
<6>[    0.724051] system 00:0a: [mem 0xfed4c000-0xffffffff] could not be =
reserved
<7>[    0.724059] system 00:0a: Plug and Play ACPI device, IDs PNP0c01 (a=
ctive)
<6>[    0.724244] pnp: PnP ACPI: found 11 devices
<7>[    0.724251] initcall pnpacpi_init+0x0/0x6a returned 0 after 5705 us=
ecs
<7>[    0.724254] calling  chr_dev_init+0x0/0x14b @ 1
<7>[    0.726116] initcall chr_dev_init+0x0/0x14b returned 0 after 1814 u=
secs
<7>[    0.726120] calling  firmware_class_init+0x0/0xe3 @ 1
<7>[    0.726125] initcall firmware_class_init+0x0/0xe3 returned 0 after =
1 usecs
<7>[    0.726128] calling  init_pcmcia_bus+0x0/0x5c @ 1
<7>[    0.726139] initcall init_pcmcia_bus+0x0/0x5c returned 0 after 8 us=
ecs
<7>[    0.726142] calling  init_acpi_pm_clocksource+0x0/0xdb @ 1
<6>[    0.730693] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffff=
ff, max_idle_ns: 2085701024 ns
<7>[    0.730700] initcall init_acpi_pm_clocksource+0x0/0xdb returned 0 a=
fter 4448 usecs
<7>[    0.730704] calling  sysctl_core_init+0x0/0x2b @ 1
<7>[    0.730728] initcall sysctl_core_init+0x0/0x2b returned 0 after 20 =
usecs
<7>[    0.730731] calling  eth_offload_init+0x0/0x14 @ 1
<7>[    0.730735] initcall eth_offload_init+0x0/0x14 returned 0 after 0 u=
secs
<7>[    0.730737] calling  ipv4_offload_init+0x0/0x74 @ 1
<7>[    0.730741] initcall ipv4_offload_init+0x0/0x74 returned 0 after 1 =
usecs
<7>[    0.730743] calling  inet_init+0x0/0x233 @ 1
<6>[    0.730759] NET: Registered protocol family 2
<6>[    0.730931] tcp_listen_portaddr_hash hash table entries: 16384 (ord=
er: 6, 262144 bytes, linear)
<6>[    0.731006] TCP established hash table entries: 262144 (order: 9, 2=
097152 bytes, linear)
<6>[    0.731431] TCP bind hash table entries: 65536 (order: 8, 1048576 b=
ytes, linear)
<6>[    0.731625] TCP: Hash tables configured (established 262144 bind 65=
536)
<6>[    0.731662] UDP hash table entries: 16384 (order: 7, 524288 bytes, =
linear)
<6>[    0.731770] UDP-Lite hash table entries: 16384 (order: 7, 524288 by=
tes, linear)
<7>[    0.731912] initcall inet_init+0x0/0x233 returned 0 after 1138 usec=
s
<7>[    0.731914] calling  af_unix_init+0x0/0x4e @ 1
<6>[    0.731917] NET: Registered protocol family 1
<7>[    0.731927] initcall af_unix_init+0x0/0x4e returned 0 after 9 usecs=

<7>[    0.731930] calling  ipv6_offload_init+0x0/0x7f @ 1
<7>[    0.731933] initcall ipv6_offload_init+0x0/0x7f returned 0 after 0 =
usecs
<7>[    0.731936] calling  cfg80211_init+0x0/0xc6 @ 1
<7>[    0.732086] initcall cfg80211_init+0x0/0xc6 returned 0 after 143 us=
ecs
<7>[    0.732090] calling  pcibios_assign_resources+0x0/0xc0 @ 1
<6>[    0.732098] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to =
[bus 01-39] add_size 1000
<6>[    0.732114] pci 0000:00:1c.0: BAR 7: assigned [io  0x2000-0x2fff]
<6>[    0.732119] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
<6>[    0.732129] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
<6>[    0.732139] pci 0000:00:1c.0:   bridge window [mem 0xd4000000-0xea0=
fffff]
<6>[    0.732147] pci 0000:00:1c.0:   bridge window [mem 0xb0000000-0xd1f=
fffff 64bit pref]
<6>[    0.732157] pci 0000:00:1c.2: PCI bridge to [bus 3a]
<6>[    0.732164] pci 0000:00:1c.2:   bridge window [mem 0xec100000-0xec1=
fffff]
<6>[    0.732177] pci 0000:00:1d.0: PCI bridge to [bus 3c]
<6>[    0.732193] pci 0000:00:1d.0:   bridge window [mem 0xec000000-0xec0=
fffff]
<6>[    0.732205] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
<6>[    0.732209] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
<6>[    0.732213] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff =
window]
<6>[    0.732217] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff =
window]
<6>[    0.732221] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff =
window]
<6>[    0.732225] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff =
window]
<6>[    0.732229] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff=
 window]
<6>[    0.732233] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff=
 window]
<6>[    0.732237] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff=
 window]
<6>[    0.732241] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff=
 window]
<6>[    0.732245] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff=
 window]
<6>[    0.732249] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff=
 window]
<6>[    0.732253] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff=
 window]
<6>[    0.732257] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff=
 window]
<6>[    0.732261] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff=
 window]
<6>[    0.732265] pci_bus 0000:00: resource 19 [mem 0x000f0000-0x000fffff=
 window]
<6>[    0.732269] pci_bus 0000:00: resource 20 [mem 0x9f800000-0xf7ffffff=
 window]
<6>[    0.732273] pci_bus 0000:00: resource 21 [mem 0xfd000000-0xfe7fffff=
 window]
<6>[    0.732277] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
<6>[    0.732281] pci_bus 0000:01: resource 1 [mem 0xd4000000-0xea0fffff]=

<6>[    0.732285] pci_bus 0000:01: resource 2 [mem 0xb0000000-0xd1ffffff =
64bit pref]
<6>[    0.732289] pci_bus 0000:3a: resource 1 [mem 0xec100000-0xec1fffff]=

<6>[    0.732293] pci_bus 0000:3c: resource 1 [mem 0xec000000-0xec0fffff]=

<7>[    0.732501] initcall pcibios_assign_resources+0x0/0xc0 returned 0 a=
fter 397 usecs
<7>[    0.732504] calling  pci_apply_final_quirks+0x0/0x132 @ 1
<6>[    0.732528] pci 0000:00:02.0: calling  pci_fixup_video+0x0/0xd0 @ 1=

<6>[    0.732535] pci 0000:00:02.0: Video device with shadowed ROM at [me=
m 0x000c0000-0x000dffff]
<6>[    0.732543] pci 0000:00:02.0: pci_fixup_video+0x0/0xd0 took 8 usecs=

<6>[    0.732553] pci 0000:00:14.0: calling  quirk_usb_early_handoff+0x0/=
0x643 @ 1
<6>[    0.732955] pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x643 too=
k 385 usecs
<6>[    0.733023] pci 0000:00:1f.6: calling  quirk_e100_interrupt+0x0/0x1=
70 @ 1
<6>[    0.733030] pci 0000:00:1f.6: quirk_e100_interrupt+0x0/0x170 took 0=
 usecs
<6>[    0.733586] PCI: CLS 0 bytes, default 64
<7>[    0.733592] initcall pci_apply_final_quirks+0x0/0x132 returned 0 af=
ter 1058 usecs
<7>[    0.733595] calling  acpi_reserve_resources+0x0/0xeb @ 1
<7>[    0.733600] initcall acpi_reserve_resources+0x0/0xeb returned 0 aft=
er 2 usecs
<7>[    0.733603] calling  populate_rootfs+0x0/0xab @ 1
<6>[    0.733647] Unpacking initramfs...
<6>[    6.606230] Freeing initrd memory: 31668K
<7>[    6.606257] initcall populate_rootfs+0x0/0xab returned 0 after 5735=
007 usecs
<7>[    6.606262] calling  pci_iommu_init+0x0/0x3f @ 1
<6>[    6.606279] DMAR: Host address width 39
<6>[    6.606283] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
<6>[    6.606309] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c=
40660462 ecap 19e2ff0505e
<6>[    6.606315] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
<6>[    6.606328] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c4=
0660462 ecap f050da
<6>[    6.606332] DMAR: RMRR base: 0x0000009aa9f000 end: 0x0000009aabefff=

<6>[    6.606336] DMAR: RMRR base: 0x0000009d000000 end: 0x0000009f7fffff=

<6>[    6.606353] DMAR: No ATSR found
<1>[    6.606425] BUG: kernel NULL pointer dereference, address: 00000000=
00000038
<1>[    6.606431] #PF: supervisor write access in kernel mode
<1>[    6.606434] #PF: error_code(0x0002) - not-present page
<6>[    6.606437] PGD 0 P4D 0=20
<4>[    6.606442] Oops: 0002 [#1] SMP PTI
<4>[    6.606447] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.9.0-devel+ =
#2
<4>[    6.606450] Hardware name: LENOVO 20HGS0TW00/20HGS0TW00, BIOS N1WET=
46S (1.25s ) 03/30/2018
<4>[    6.606459] RIP: 0010:intel_iommu_init+0xed0/0x1136
<4>[    6.606463] Code: fe e9 61 02 00 00 bb f4 ff ff ff e9 57 02 00 00 4=
8 63 d1 48 c1 e2 04 48 03 50 20 48 8b 12 48 85 d2 74 0b 48 8b 92 d0 02 00=
 00 <48> 89 7a 38 ff c1 e9 15 f5 ff ff 48 c7 c7 80 98 6c a4 49 c7 c7 c0
<4>[    6.606470] RSP: 0000:ffffb28b40073dd0 EFLAGS: 00010282
<4>[    6.606474] RAX: ffff9b6b437e8060 RBX: 0000000000000000 RCX: 000000=
0000000000
<4>[    6.606478] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffff=
ffffffffff
<4>[    6.606481] RBP: ffffb28b40073e90 R08: 0000000000000001 R09: ffff9b=
6b4390f780
<4>[    6.606485] R10: 0000000000000226 R11: 0000000000000226 R12: 000000=
000000000b
<4>[    6.606489] R13: ffff9b6b4364e650 R14: ffffffffa5026d60 R15: 000000=
0000000000
<4>[    6.606493] FS:  0000000000000000(0000) GS:ffff9b6b47400000(0000) k=
nlGS:0000000000000000
<4>[    6.606497] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[    6.606501] CR2: 0000000000000038 CR3: 000000011800a001 CR4: 000000=
00003706f0
<4>[    6.606504] Call Trace:
<4>[    6.606515]  ? vprintk_emit+0xff/0x1f0
<4>[    6.606521]  ? rdinit_setup+0x2c/0x2c
<4>[    6.606526]  ? printk+0x58/0x6f
<4>[    6.606531]  ? rdinit_setup+0x2c/0x2c
<4>[    6.606536]  ? e820__memblock_setup+0x8b/0x8b
<4>[    6.606541]  pci_iommu_init+0x16/0x3f
<4>[    6.606546]  do_one_initcall+0x46/0x1e4
<4>[    6.606551]  kernel_init_freeable+0x169/0x1b2
<4>[    6.606558]  ? rest_init+0x9f/0x9f
<4>[    6.606562]  kernel_init+0xa/0x101
<4>[    6.606566]  ret_from_fork+0x22/0x30
<4>[    6.606570] Modules linked in:
<4>[    6.606575] CR2: 0000000000000038
<4>[    6.606584] ---[ end trace 5a83e8313d1e30c0 ]---

No errors detected

--------------C3F9CFC4B3CABC675A65CB7D
Content-Type: text/x-patch; charset="UTF-8"; name="intel-iommu.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="intel-iommu.patch"

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f8177c59d229..2d285a42db3f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4053,7 +4053,8 @@ static void __init init_no_remapping_devices(void)
 			drhd->ignored =3D 1;
 			for_each_active_dev_scope(drhd->devices,
 						  drhd->devices_cnt, i, dev)
-				dev_iommu_priv_set(dev, DUMMY_DEVICE_DOMAIN_INFO);
+				if (dev->iommu)
+					dev_iommu_priv_set(dev, DUMMY_DEVICE_DOMAIN_INFO);
 		}
 	}
 }

--------------C3F9CFC4B3CABC675A65CB7D
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--------------C3F9CFC4B3CABC675A65CB7D--


