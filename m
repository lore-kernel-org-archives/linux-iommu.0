Return-Path: <SRS0=k0pT=6I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75F2C2BA19
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 00:40:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692E320724
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 00:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5XtzGMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692E320724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2622C86E40;
	Fri, 24 Apr 2020 00:40:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ap3kVwGFKTut; Fri, 24 Apr 2020 00:40:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 04D8886D4D;
	Fri, 24 Apr 2020 00:40:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E91CEC1797;
	Fri, 24 Apr 2020 00:40:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06885C0175
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 00:40:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F10E286D79
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 00:40:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jng3oQGKn4FQ for <iommu@lists.linux-foundation.org>;
 Fri, 24 Apr 2020 00:40:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BE99E86D4D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 00:40:51 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id x25so8613145wmc.0
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 17:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=ABbQb6JoR0qhehmXN7sH1tbHQxEb2jUgD/l4aeDHVQk=;
 b=D5XtzGMI28kGNj32u3dRfQyVvAIb2EW7ybfJ6c17o0+7oMDkK75jSytPRRFhpxj6jh
 ElbYMGSxLQi9lRXCr8fhny/I1NoJDXUkIFbwif4FedCWinfN3tBcCGt0erUksO4S0kQF
 yEJiJg30FSYf8hkCcSaZVuuVYl+RB123K6IzTTLpVq+YHSiVrgY+Z0wy9P9gl0puDFrY
 w50b9Vq3xCmvO/X4ZpLCAFt1B8Kue11gD4jcMeVppN3rlgcy2xJCrfh1a9hZ7yy0lkc5
 zIZQsGhudiKDhkQtuwoC9KLtj0vtmnLsHVlIVxk019z36IRIn4M6VGi4GWigNgzERYUN
 XMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=ABbQb6JoR0qhehmXN7sH1tbHQxEb2jUgD/l4aeDHVQk=;
 b=pGn3gl52MYaU3tptfq4lc73P/0M3Ya180fspvA9NEYn4cw72vGn5OzUIouXnYYyQbd
 J2lYs1bbheNArUQYMoCBLd/lXWVd31KPjMXWWDdRYAxITeZU47+uVf9fO6GuHl7Y7V/O
 17e05W1wEy4y7+40Y9gj9Ysp+r9AKhU5f2oqS9ad2R7yH1JgI7DtCKwt+mHgdlmY93u7
 FesTVV0PioKg+GgjLQDBSZyqf5D85fIDILx6XW4NlC/e3MyvmUF8SR7PA+eQEjhyJXa2
 ZxggyuB1kZog60nhCpVxdFp43cx5ZSiuu9aVFBh2Ii0XIFlLenpcKjJafQtnZCpM0AC9
 QucA==
X-Gm-Message-State: AGi0PuYi1l+mTEKqd9Mv9XsTHznzZ+fLAY58UHemydVkOh61xpAqdE1f
 arhbKAbtZwJJUdqTQD7Gh+LVIdpwtOwwRP7O9mvHePs8
X-Google-Smtp-Source: APiQypLq6L2Ypzpcunvr9A3X0SJ53ieNTI7mO5PqhKFDWvChs9qKEyHjFO0Q3ckvruulzSKw0/dKlZYj70iCOt+NnMg=
X-Received: by 2002:a05:600c:2214:: with SMTP id
 z20mr7529643wml.189.1587688849657; 
 Thu, 23 Apr 2020 17:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAEbUFv6SHY8z2kuNFwZ4khFwgqLZjxi4-KfDv5kVANeROMU_Vw@mail.gmail.com>
 <CAEbUFv5AybVFe8Wg6ZKLaiUoUj25G_oRk+Xi_HVSvb6pTsgYzQ@mail.gmail.com>
In-Reply-To: <CAEbUFv5AybVFe8Wg6ZKLaiUoUj25G_oRk+Xi_HVSvb6pTsgYzQ@mail.gmail.com>
From: Bin <anole1949@gmail.com>
Date: Fri, 24 Apr 2020 08:40:37 +0800
Message-ID: <CAEbUFv7YZCh5V5btB4npBLg_FcZqB01LOp_QQKM7qURmucPAqQ@mail.gmail.com>
Subject: Re: iommu_iova slab eats too much memory
To: iommu@lists.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============8280887608102650886=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============8280887608102650886==
Content-Type: multipart/alternative; boundary="000000000000e5d33d05a3fe9d3b"

--000000000000e5d33d05a3fe9d3b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello? anyone there?

Bin <anole1949@gmail.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8823=E6=97=A5=E5=91=
=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:14=E5=86=99=E9=81=93=EF=BC=9A

> Forget to mention, I've already disabled the slab merge, so this is what
> it is.
>
> Bin <anole1949@gmail.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8823=E6=97=A5=E5=
=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:11=E5=86=99=E9=81=93=EF=BC=9A
>
>> Hey, guys:
>>
>> I'm running a batch of CoreOS boxes, the lsb_release is:
>>
>> ```
>> # cat /etc/lsb-release
>> DISTRIB_ID=3D"Container Linux by CoreOS"
>> DISTRIB_RELEASE=3D2303.3.0
>> DISTRIB_CODENAME=3D"Rhyolite"
>> DISTRIB_DESCRIPTION=3D"Container Linux by CoreOS 2303.3.0 (Rhyolite)"
>> ```
>>
>> ```
>> # uname -a
>> Linux cloud-worker-25 4.19.86-coreos #1 SMP Mon Dec 2 20:13:38 -00 2019
>> x86_64 Intel(R) Xeon(R) CPU E5-2640 v2 @ 2.00GHz GenuineIntel GNU/Linux
>> ```
>> Recently, I found my vms constently being killed due to OOM, and after
>> digging into the problem, I finally realized that the kernel is leaking
>> memory.
>>
>> Here's my slabinfo:
>>
>>  Active / Total Objects (% used)    : 83818306 / 84191607 (99.6%)
>>  Active / Total Slabs (% used)      : 1336293 / 1336293 (100.0%)
>>  Active / Total Caches (% used)     : 152 / 217 (70.0%)
>>  Active / Total Size (% used)       : 5828768.08K / 5996848.72K (97.2%)
>>  Minimum / Average / Maximum Object : 0.01K / 0.07K / 23.25K
>>
>>   OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
>>
>> 80253888 80253888 100%    0.06K 1253967       64   5015868K iommu_iova
>>
>> 489472 489123  99%    0.03K   3824      128     15296K kmalloc-32
>>
>> 297444 271112  91%    0.19K   7082       42     56656K dentry
>>
>> 254400 252784  99%    0.06K   3975       64     15900K anon_vma_chain
>>
>> 222528  39255  17%    0.50K   6954       32    111264K kmalloc-512
>>
>> 202482 201814  99%    0.19K   4821       42     38568K vm_area_struct
>>
>> 200192 200192 100%    0.01K    391      512      1564K kmalloc-8
>>
>> 170528 169359  99%    0.25K   5329       32     42632K filp
>>
>> 158144 153508  97%    0.06K   2471       64      9884K kmalloc-64
>>
>> 149914 149365  99%    0.09K   3259       46     13036K anon_vma
>>
>> 146640 143123  97%    0.10K   3760       39     15040K buffer_head
>>
>> 130368  32791  25%    0.09K   3104       42     12416K kmalloc-96
>>
>> 129752 129752 100%    0.07K   2317       56      9268K Acpi-Operand
>>
>> 105468 105106  99%    0.04K   1034      102      4136K
>> selinux_inode_security
>>  73080  73080 100%    0.13K   2436       30      9744K kernfs_node_cache
>>
>>  72360  70261  97%    0.59K   1340       54     42880K inode_cache
>>
>>  71040  71040 100%    0.12K   2220       32      8880K eventpoll_epi
>>
>>  68096  59262  87%    0.02K    266      256      1064K kmalloc-16
>>
>>  53652  53652 100%    0.04K    526      102      2104K pde_opener
>>
>>  50496  31654  62%    2.00K   3156       16    100992K kmalloc-2048
>>
>>  46242  46242 100%    0.19K   1101       42      8808K cred_jar
>>
>>  44496  43013  96%    0.66K    927       48     29664K proc_inode_cache
>>
>>  44352  44352 100%    0.06K    693       64      2772K task_delay_info
>>
>>  43516  43471  99%    0.69K    946       46     30272K sock_inode_cache
>>
>>  37856  27626  72%    1.00K   1183       32     37856K kmalloc-1024
>>
>>  36736  36736 100%    0.07K    656       56      2624K eventpoll_pwq
>>
>>  34076  31282  91%    0.57K   1217       28     19472K radix_tree_node
>>
>>  33660  30528  90%    1.05K   1122       30     35904K ext4_inode_cache
>>
>>  32760  30959  94%    0.19K    780       42      6240K kmalloc-192
>>
>>  32028  32028 100%    0.04K    314      102      1256K ext4_extent_statu=
s
>>
>>  30048  30048 100%    0.25K    939       32      7512K skbuff_head_cache
>>
>>  28736  28736 100%    0.06K    449       64      1796K fs_cache
>>
>>  24702  24702 100%    0.69K    537       46     17184K files_cache
>>
>>  23808  23808 100%    0.66K    496       48     15872K ovl_inode
>>
>>  23104  22945  99%    0.12K    722       32      2888K kmalloc-128
>>
>>  22724  21307  93%    0.69K    494       46     15808K shmem_inode_cache
>>
>>  21472  21472 100%    0.12K    671       32      2684K seq_file
>>
>>  19904  19904 100%    1.00K    622       32     19904K UNIX
>>
>>  17340  17340 100%    1.06K    578       30     18496K mm_struct
>>
>>  15980  15980 100%    0.02K     94      170       376K avtab_node
>>
>>  14070  14070 100%    1.06K    469       30     15008K signal_cache
>>
>>  13248  13248 100%    0.12K    414       32      1656K pid
>>
>>  12128  11777  97%    0.25K    379       32      3032K kmalloc-256
>>
>>  11008  11008 100%    0.02K     43      256       172K
>> selinux_file_security
>>  10812  10812 100%    0.04K    106      102       424K Acpi-Namespace
>>
>> These information shows that the 'iommu_iova' is the top memory consumer=
.
>> In order to optimize the network performence of Openstack virtual machin=
es,
>> I enabled the vt-d feature in bios and sriov feature of Intel 82599 10G
>> NIC. I'm assuming this is the root cause of this issue.
>>
>> Is there anything I can do to fix it?
>>
>

--000000000000e5d33d05a3fe9d3b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGVsbG8/IGFueW9uZSB0aGVyZT88L2Rpdj48YnI+PGRpdiBjbGFzcz0i
Z21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5CaW4gJmx0Ozxh
IGhyZWY9Im1haWx0bzphbm9sZTE5NDlAZ21haWwuY29tIj5hbm9sZTE5NDlAZ21haWwuY29tPC9h
PiZndDsg5LqOMjAyMOW5tDTmnIgyM+aXpeWRqOWbmyDkuIvljYg1OjE05YaZ6YGT77yaPGJyPjwv
ZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4
IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5n
LWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj5Gb3JnZXQgdG8gbWVudGlvbiwgSSYjMzk7dmUgYWxy
ZWFkeSBkaXNhYmxlZCB0aGUgc2xhYiBtZXJnZSwgc28gdGhpcyBpcyB3aGF0IGl0IGlzLjwvZGl2
Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWls
X2F0dHIiPkJpbiAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFub2xlMTk0OUBnbWFpbC5jb20iIHRhcmdl
dD0iX2JsYW5rIj5hbm9sZTE5NDlAZ21haWwuY29tPC9hPiZndDsg5LqOMjAyMOW5tDTmnIgyM+aX
peWRqOWbmyDkuIvljYg1OjEx5YaZ6YGT77yaPGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJn
bWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDox
cHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRy
Ij5IZXksIGd1eXM6PGRpdj48YnI+PC9kaXY+PGRpdj5JJiMzOTttIHJ1bm5pbmcgYSBiYXRjaCBv
ZiBDb3JlT1MgYm94ZXMsIHRoZSBsc2JfcmVsZWFzZSBpczo8YnI+PGJyPmBgYDxicj4jIGNhdCAv
ZXRjL2xzYi1yZWxlYXNlPGJyPkRJU1RSSUJfSUQ9JnF1b3Q7Q29udGFpbmVyIExpbnV4IGJ5IENv
cmVPUyZxdW90Ozxicj5ESVNUUklCX1JFTEVBU0U9MjMwMy4zLjA8YnI+RElTVFJJQl9DT0RFTkFN
RT0mcXVvdDtSaHlvbGl0ZSZxdW90Ozxicj5ESVNUUklCX0RFU0NSSVBUSU9OPSZxdW90O0NvbnRh
aW5lciBMaW51eCBieSBDb3JlT1MgMjMwMy4zLjAgKFJoeW9saXRlKSZxdW90Ozxicj5gYGA8YnI+
PGJyPmBgYDxicj4jIHVuYW1lIC1hPGJyPkxpbnV4IGNsb3VkLXdvcmtlci0yNSA0LjE5Ljg2LWNv
cmVvcyAjMSBTTVAgTW9uIERlYyAyIDIwOjEzOjM4IC0wMCAyMDE5PGJyPng4Nl82NCBJbnRlbChS
KSBYZW9uKFIpIENQVSBFNS0yNjQwIHYyIEAgMi4wMEdIeiBHZW51aW5lSW50ZWwgR05VL0xpbnV4
PGJyPmBgYDxicj5SZWNlbnRseSwgSSBmb3VuZCBteSB2bXMgY29uc3RlbnRseSBiZWluZyBraWxs
ZWQgZHVlIHRvIE9PTSwgYW5kIGFmdGVyPGJyPmRpZ2dpbmcgaW50byB0aGUgcHJvYmxlbSwgSSBm
aW5hbGx5IHJlYWxpemVkIHRoYXQgdGhlIGtlcm5lbCBpcyBsZWFraW5nPGJyPm1lbW9yeS48YnI+
PGJyPkhlcmUmIzM5O3MgbXkgc2xhYmluZm86PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
wqBBY3RpdmUgLyBUb3RhbCBPYmplY3RzICglIHVzZWQpIMKgIMKgOiA4MzgxODMwNiAvIDg0MTkx
NjA3ICg5OS42JSk8YnI+wqBBY3RpdmUgLyBUb3RhbCBTbGFicyAoJSB1c2VkKSDCoCDCoCDCoDog
MTMzNjI5MyAvIDEzMzYyOTMgKDEwMC4wJSk8YnI+wqBBY3RpdmUgLyBUb3RhbCBDYWNoZXMgKCUg
dXNlZCkgwqAgwqAgOiAxNTIgLyAyMTcgKDcwLjAlKTxicj7CoEFjdGl2ZSAvIFRvdGFsIFNpemUg
KCUgdXNlZCkgwqAgwqAgwqAgOiA1ODI4NzY4LjA4SyAvIDU5OTY4NDguNzJLICg5Ny4yJSk8YnI+
wqBNaW5pbXVtIC8gQXZlcmFnZSAvIE1heGltdW0gT2JqZWN0IDogMC4wMUsgLyAwLjA3SyAvIDIz
LjI1Szxicj48YnI+wqAgT0JKUyBBQ1RJVkUgwqBVU0UgT0JKIFNJWkUgwqBTTEFCUyBPQkovU0xB
QiBDQUNIRSBTSVpFIE5BTUUgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPjgwMjUzODg4
IDgwMjUzODg4IDEwMCUgwqAgwqAwLjA2SyAxMjUzOTY3IMKgIMKgIMKgIDY0IMKgIDUwMTU4NjhL
IGlvbW11X2lvdmEgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPjQ4OTQ3MiA0ODkxMjMgwqA5OSUgwqAg
wqAwLjAzSyDCoCAzODI0IMKgIMKgIMKgMTI4IMKgIMKgIDE1Mjk2SyBrbWFsbG9jLTMyIMKgIMKg
IMKgIMKgIMKgIMKgIDxicj4yOTc0NDQgMjcxMTEyIMKgOTElIMKgIMKgMC4xOUsgwqAgNzA4MiDC
oCDCoCDCoCA0MiDCoCDCoCA1NjY1NksgZGVudHJ5IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxi
cj4yNTQ0MDAgMjUyNzg0IMKgOTklIMKgIMKgMC4wNksgwqAgMzk3NSDCoCDCoCDCoCA2NCDCoCDC
oCAxNTkwMEsgYW5vbl92bWFfY2hhaW4gwqAgwqAgwqAgwqAgPGJyPjIyMjUyOCDCoDM5MjU1IMKg
MTclIMKgIMKgMC41MEsgwqAgNjk1NCDCoCDCoCDCoCAzMiDCoCDCoDExMTI2NEsga21hbGxvYy01
MTIgwqAgwqAgwqAgwqAgwqAgwqA8YnI+MjAyNDgyIDIwMTgxNCDCoDk5JSDCoCDCoDAuMTlLIMKg
IDQ4MjEgwqAgwqAgwqAgNDIgwqAgwqAgMzg1NjhLIHZtX2FyZWFfc3RydWN0IMKgIMKgIMKgIMKg
IDxicj4yMDAxOTIgMjAwMTkyIDEwMCUgwqAgwqAwLjAxSyDCoCDCoDM5MSDCoCDCoCDCoDUxMiDC
oCDCoCDCoDE1NjRLIGttYWxsb2MtOCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4xNzA1MjggMTY5
MzU5IMKgOTklIMKgIMKgMC4yNUsgwqAgNTMyOSDCoCDCoCDCoCAzMiDCoCDCoCA0MjYzMksgZmls
cCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+MTU4MTQ0IDE1MzUwOCDCoDk3JSDCoCDC
oDAuMDZLIMKgIDI0NzEgwqAgwqAgwqAgNjQgwqAgwqAgwqA5ODg0SyBrbWFsbG9jLTY0IMKgIMKg
IMKgIMKgIMKgIMKgIDxicj4xNDk5MTQgMTQ5MzY1IMKgOTklIMKgIMKgMC4wOUsgwqAgMzI1OSDC
oCDCoCDCoCA0NiDCoCDCoCAxMzAzNksgYW5vbl92bWEgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJy
PjE0NjY0MCAxNDMxMjMgwqA5NyUgwqAgwqAwLjEwSyDCoCAzNzYwIMKgIMKgIMKgIDM5IMKgIMKg
IDE1MDQwSyBidWZmZXJfaGVhZCDCoCDCoCDCoCDCoCDCoCDCoDxicj4xMzAzNjggwqAzMjc5MSDC
oDI1JSDCoCDCoDAuMDlLIMKgIDMxMDQgwqAgwqAgwqAgNDIgwqAgwqAgMTI0MTZLIGttYWxsb2Mt
OTYgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPjEyOTc1MiAxMjk3NTIgMTAwJSDCoCDCoDAuMDdLIMKg
IDIzMTcgwqAgwqAgwqAgNTYgwqAgwqAgwqA5MjY4SyBBY3BpLU9wZXJhbmQgwqAgwqAgwqAgwqAg
wqAgPGJyPjEwNTQ2OCAxMDUxMDYgwqA5OSUgwqAgwqAwLjA0SyDCoCAxMDM0IMKgIMKgIMKgMTAy
IMKgIMKgIMKgNDEzNksgc2VsaW51eF9pbm9kZV9zZWN1cml0eSA8YnI+wqA3MzA4MCDCoDczMDgw
IDEwMCUgwqAgwqAwLjEzSyDCoCAyNDM2IMKgIMKgIMKgIDMwIMKgIMKgIMKgOTc0NEsga2VybmZz
X25vZGVfY2FjaGUgwqAgwqAgwqA8YnI+wqA3MjM2MCDCoDcwMjYxIMKgOTclIMKgIMKgMC41OUsg
wqAgMTM0MCDCoCDCoCDCoCA1NCDCoCDCoCA0Mjg4MEsgaW5vZGVfY2FjaGUgwqAgwqAgwqAgwqAg
wqAgwqA8YnI+wqA3MTA0MCDCoDcxMDQwIDEwMCUgwqAgwqAwLjEySyDCoCAyMjIwIMKgIMKgIMKg
IDMyIMKgIMKgIMKgODg4MEsgZXZlbnRwb2xsX2VwaSDCoCDCoCDCoCDCoCDCoDxicj7CoDY4MDk2
IMKgNTkyNjIgwqA4NyUgwqAgwqAwLjAySyDCoCDCoDI2NiDCoCDCoCDCoDI1NiDCoCDCoCDCoDEw
NjRLIGttYWxsb2MtMTYgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPsKgNTM2NTIgwqA1MzY1MiAxMDAl
IMKgIMKgMC4wNEsgwqAgwqA1MjYgwqAgwqAgwqAxMDIgwqAgwqAgwqAyMTA0SyBwZGVfb3BlbmVy
IMKgIMKgIMKgIMKgIMKgIMKgIDxicj7CoDUwNDk2IMKgMzE2NTQgwqA2MiUgwqAgwqAyLjAwSyDC
oCAzMTU2IMKgIMKgIMKgIDE2IMKgIMKgMTAwOTkySyBrbWFsbG9jLTIwNDggwqAgwqAgwqAgwqAg
wqAgPGJyPsKgNDYyNDIgwqA0NjI0MiAxMDAlIMKgIMKgMC4xOUsgwqAgMTEwMSDCoCDCoCDCoCA0
MiDCoCDCoCDCoDg4MDhLIGNyZWRfamFyIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj7CoDQ0NDk2
IMKgNDMwMTMgwqA5NiUgwqAgwqAwLjY2SyDCoCDCoDkyNyDCoCDCoCDCoCA0OCDCoCDCoCAyOTY2
NEsgcHJvY19pbm9kZV9jYWNoZSDCoCDCoCDCoCA8YnI+wqA0NDM1MiDCoDQ0MzUyIDEwMCUgwqAg
wqAwLjA2SyDCoCDCoDY5MyDCoCDCoCDCoCA2NCDCoCDCoCDCoDI3NzJLIHRhc2tfZGVsYXlfaW5m
byDCoCDCoCDCoCDCoDxicj7CoDQzNTE2IMKgNDM0NzEgwqA5OSUgwqAgwqAwLjY5SyDCoCDCoDk0
NiDCoCDCoCDCoCA0NiDCoCDCoCAzMDI3Mksgc29ja19pbm9kZV9jYWNoZSDCoCDCoCDCoCA8YnI+
wqAzNzg1NiDCoDI3NjI2IMKgNzIlIMKgIMKgMS4wMEsgwqAgMTE4MyDCoCDCoCDCoCAzMiDCoCDC
oCAzNzg1Nksga21hbGxvYy0xMDI0IMKgIMKgIMKgIMKgIMKgIDxicj7CoDM2NzM2IMKgMzY3MzYg
MTAwJSDCoCDCoDAuMDdLIMKgIMKgNjU2IMKgIMKgIMKgIDU2IMKgIMKgIMKgMjYyNEsgZXZlbnRw
b2xsX3B3cSDCoCDCoCDCoCDCoCDCoDxicj7CoDM0MDc2IMKgMzEyODIgwqA5MSUgwqAgwqAwLjU3
SyDCoCAxMjE3IMKgIMKgIMKgIDI4IMKgIMKgIDE5NDcySyByYWRpeF90cmVlX25vZGUgwqAgwqAg
wqAgwqA8YnI+wqAzMzY2MCDCoDMwNTI4IMKgOTAlIMKgIMKgMS4wNUsgwqAgMTEyMiDCoCDCoCDC
oCAzMCDCoCDCoCAzNTkwNEsgZXh0NF9pbm9kZV9jYWNoZSDCoCDCoCDCoCA8YnI+wqAzMjc2MCDC
oDMwOTU5IMKgOTQlIMKgIMKgMC4xOUsgwqAgwqA3ODAgwqAgwqAgwqAgNDIgwqAgwqAgwqA2MjQw
SyBrbWFsbG9jLTE5MiDCoCDCoCDCoCDCoCDCoCDCoDxicj7CoDMyMDI4IMKgMzIwMjggMTAwJSDC
oCDCoDAuMDRLIMKgIMKgMzE0IMKgIMKgIMKgMTAyIMKgIMKgIMKgMTI1NksgZXh0NF9leHRlbnRf
c3RhdHVzIMKgIMKgIDxicj7CoDMwMDQ4IMKgMzAwNDggMTAwJSDCoCDCoDAuMjVLIMKgIMKgOTM5
IMKgIMKgIMKgIDMyIMKgIMKgIMKgNzUxMksgc2tidWZmX2hlYWRfY2FjaGUgwqAgwqAgwqA8YnI+
wqAyODczNiDCoDI4NzM2IDEwMCUgwqAgwqAwLjA2SyDCoCDCoDQ0OSDCoCDCoCDCoCA2NCDCoCDC
oCDCoDE3OTZLIGZzX2NhY2hlIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj7CoDI0NzAyIMKgMjQ3
MDIgMTAwJSDCoCDCoDAuNjlLIMKgIMKgNTM3IMKgIMKgIMKgIDQ2IMKgIMKgIDE3MTg0SyBmaWxl
c19jYWNoZSDCoCDCoCDCoCDCoCDCoCDCoDxicj7CoDIzODA4IMKgMjM4MDggMTAwJSDCoCDCoDAu
NjZLIMKgIMKgNDk2IMKgIMKgIMKgIDQ4IMKgIMKgIDE1ODcySyBvdmxfaW5vZGUgwqAgwqAgwqAg
wqAgwqAgwqAgwqA8YnI+wqAyMzEwNCDCoDIyOTQ1IMKgOTklIMKgIMKgMC4xMksgwqAgwqA3MjIg
wqAgwqAgwqAgMzIgwqAgwqAgwqAyODg4SyBrbWFsbG9jLTEyOCDCoCDCoCDCoCDCoCDCoCDCoDxi
cj7CoDIyNzI0IMKgMjEzMDcgwqA5MyUgwqAgwqAwLjY5SyDCoCDCoDQ5NCDCoCDCoCDCoCA0NiDC
oCDCoCAxNTgwOEsgc2htZW1faW5vZGVfY2FjaGUgwqAgwqAgwqA8YnI+wqAyMTQ3MiDCoDIxNDcy
IDEwMCUgwqAgwqAwLjEySyDCoCDCoDY3MSDCoCDCoCDCoCAzMiDCoCDCoCDCoDI2ODRLIHNlcV9m
aWxlIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj7CoDE5OTA0IMKgMTk5MDQgMTAwJSDCoCDCoDEu
MDBLIMKgIMKgNjIyIMKgIMKgIMKgIDMyIMKgIMKgIDE5OTA0SyBVTklYIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIDxicj7CoDE3MzQwIMKgMTczNDAgMTAwJSDCoCDCoDEuMDZLIMKgIMKgNTc4
IMKgIMKgIMKgIDMwIMKgIMKgIDE4NDk2SyBtbV9zdHJ1Y3QgwqAgwqAgwqAgwqAgwqAgwqAgwqA8
YnI+wqAxNTk4MCDCoDE1OTgwIDEwMCUgwqAgwqAwLjAySyDCoCDCoCA5NCDCoCDCoCDCoDE3MCDC
oCDCoCDCoCAzNzZLIGF2dGFiX25vZGUgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPsKgMTQwNzAgwqAx
NDA3MCAxMDAlIMKgIMKgMS4wNksgwqAgwqA0NjkgwqAgwqAgwqAgMzAgwqAgwqAgMTUwMDhLIHNp
Z25hbF9jYWNoZSDCoCDCoCDCoCDCoCDCoCA8YnI+wqAxMzI0OCDCoDEzMjQ4IDEwMCUgwqAgwqAw
LjEySyDCoCDCoDQxNCDCoCDCoCDCoCAzMiDCoCDCoCDCoDE2NTZLIHBpZCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoDxicj7CoDEyMTI4IMKgMTE3NzcgwqA5NyUgwqAgwqAwLjI1SyDCoCDC
oDM3OSDCoCDCoCDCoCAzMiDCoCDCoCDCoDMwMzJLIGttYWxsb2MtMjU2IMKgIMKgIMKgIMKgIMKg
IMKgPGJyPsKgMTEwMDggwqAxMTAwOCAxMDAlIMKgIMKgMC4wMksgwqAgwqAgNDMgwqAgwqAgwqAy
NTYgwqAgwqAgwqAgMTcySyBzZWxpbnV4X2ZpbGVfc2VjdXJpdHkgwqA8YnI+wqAxMDgxMiDCoDEw
ODEyIDEwMCUgwqAgwqAwLjA0SyDCoCDCoDEwNiDCoCDCoCDCoDEwMiDCoCDCoCDCoCA0MjRLIEFj
cGktTmFtZXNwYWNlwqAgwqAgwqA8YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGVzZSBp
bmZvcm1hdGlvbiBzaG93cyB0aGF0IHRoZSAmIzM5O2lvbW11X2lvdmEmIzM5OyBpcyB0aGUgdG9w
IG1lbW9yeSBjb25zdW1lci4gSW4gb3JkZXIgdG8gb3B0aW1pemUgdGhlIG5ldHdvcmsgcGVyZm9y
bWVuY2Ugb2YgT3BlbnN0YWNrIHZpcnR1YWwgbWFjaGluZXMsIEkgZW5hYmxlZCB0aGUgdnQtZCBm
ZWF0dXJlIGluIGJpb3MgYW5kIHNyaW92IGZlYXR1cmUgb2YgSW50ZWwgODI1OTkgMTBHIE5JQy4g
SSYjMzk7bSBhc3N1bWluZyB0aGlzIGlzIHRoZSByb290IGNhdXNlIG9mIHRoaXMgaXNzdWUuPC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JcyB0aGVyZSBhbnl0aGluZyBJIGNhbiBkbyB0byBmaXgg
aXQ/PC9kaXY+PC9kaXY+DQo8L2Jsb2NrcXVvdGU+PC9kaXY+DQo8L2Jsb2NrcXVvdGU+PC9kaXY+
DQo=
--000000000000e5d33d05a3fe9d3b--

--===============8280887608102650886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8280887608102650886==--
