Return-Path: <SRS0=eKRE=6H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21C9C55186
	for <iommu@archiver.kernel.org>; Thu, 23 Apr 2020 14:12:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6651C2098B
	for <iommu@archiver.kernel.org>; Thu, 23 Apr 2020 14:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEKsuD0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6651C2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3AE1C86925;
	Thu, 23 Apr 2020 14:12:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L8tLhBqUuOXx; Thu, 23 Apr 2020 14:12:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0426186910;
	Thu, 23 Apr 2020 14:12:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0E70C1D7F;
	Thu, 23 Apr 2020 14:12:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B81C6C0175
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 09:14:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A034D23100
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 09:14:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lfz1qa1M+aGl for <iommu@lists.linux-foundation.org>;
 Thu, 23 Apr 2020 09:14:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by silver.osuosl.org (Postfix) with ESMTPS id E2C9E227AD
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 09:14:31 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id k13so5934748wrw.7
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 02:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=uCaUafEWShc9HQpTn/gSNLj+y2ggmkomiLvKOoLsxvg=;
 b=nEKsuD0WeyNcxb54aFd4rCQPZG2XcIywU9d1AZB9XR6czbdpd9ieKxN0FsoztR0Ytq
 8UjqMAwVLb/n+bk0VQ8Jeo4+lAJ3qJ/WKdhC/mATOmlDD9a/f97H/4GD8Udke3zZw6de
 YGMSrkqc++KahGpmVIel6M8eYtOUAixO1GmReUU6QRTHQOggrT3EKD/NImqHZJ41U5Dj
 rvlsOdGUEtcDqUp3qnetxj+rm691Yo4E2BGYOwdpU+Jrts5LfMBRE2X5mhtzjczO0S8M
 Op6MwH/3CjLkRbJUT6gitbd4EQy7Irq+WJJzgNBmVtkM8fEhtNjVevKPqQCKHSQVVmXK
 en3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=uCaUafEWShc9HQpTn/gSNLj+y2ggmkomiLvKOoLsxvg=;
 b=T2wSV8Npl9oH6qeY46vyiqePmb/RkEBjVFTS1gcxkszeO4aEoB2vFA4qtqcHNy6XT6
 ud8qzd/TECOk6kwX5SSzGDzD+NRxFLzAVOavfRwABEgC5lYEKELnX8DHT/cXO+z21uYe
 xEHD2WXs6IBRI5/f3U0SIPjDSKHKs/m3drrsLDwwX+k4FmSxyAWnrUvqBfgUgCDVbFK0
 r2Wuu5p26qVHwfTw9wPgbYWTT1UVw4K5TVAbTa2slIToAQslvX3Mr0oILXKPB/czOvk8
 OoKRQKxrx/Q3QsgKSZe4nEl/7eeOITCWpoGy/9p4alG2O0Xn0SxiDODy5iUU8SXK/jqo
 3XuQ==
X-Gm-Message-State: AGi0PuZdn32G68pMkk2U9u25COGtOIPplX7umdYn02ac+JRaLsrgR5wL
 rcflP0oaIBY84N42Rmb0isPCI5xCbMB9zo+7Zj4yEoMM
X-Google-Smtp-Source: APiQypKKVtj21C61Wu7GpnlgDhTVrleFygLdpeEjxS3whp81sCd+QVshKk9l8PfPND56Q+f2Jd+CtGSyYSqgezfC/bM=
X-Received: by 2002:a5d:420a:: with SMTP id n10mr3623335wrq.235.1587633269832; 
 Thu, 23 Apr 2020 02:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAEbUFv6SHY8z2kuNFwZ4khFwgqLZjxi4-KfDv5kVANeROMU_Vw@mail.gmail.com>
In-Reply-To: <CAEbUFv6SHY8z2kuNFwZ4khFwgqLZjxi4-KfDv5kVANeROMU_Vw@mail.gmail.com>
From: Bin <anole1949@gmail.com>
Date: Thu, 23 Apr 2020 17:14:17 +0800
Message-ID: <CAEbUFv5AybVFe8Wg6ZKLaiUoUj25G_oRk+Xi_HVSvb6pTsgYzQ@mail.gmail.com>
Subject: Re: iommu_iova slab eats too much memory
To: iommu@lists.linux-foundation.org
X-Mailman-Approved-At: Thu, 23 Apr 2020 14:12:44 +0000
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
Content-Type: multipart/mixed; boundary="===============5861730166343398992=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============5861730166343398992==
Content-Type: multipart/alternative; boundary="00000000000014ffcd05a3f1ad18"

--00000000000014ffcd05a3f1ad18
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Forget to mention, I've already disabled the slab merge, so this is what it
is.

Bin <anole1949@gmail.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8823=E6=97=A5=E5=91=
=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:11=E5=86=99=E9=81=93=EF=BC=9A

> Hey, guys:
>
> I'm running a batch of CoreOS boxes, the lsb_release is:
>
> ```
> # cat /etc/lsb-release
> DISTRIB_ID=3D"Container Linux by CoreOS"
> DISTRIB_RELEASE=3D2303.3.0
> DISTRIB_CODENAME=3D"Rhyolite"
> DISTRIB_DESCRIPTION=3D"Container Linux by CoreOS 2303.3.0 (Rhyolite)"
> ```
>
> ```
> # uname -a
> Linux cloud-worker-25 4.19.86-coreos #1 SMP Mon Dec 2 20:13:38 -00 2019
> x86_64 Intel(R) Xeon(R) CPU E5-2640 v2 @ 2.00GHz GenuineIntel GNU/Linux
> ```
> Recently, I found my vms constently being killed due to OOM, and after
> digging into the problem, I finally realized that the kernel is leaking
> memory.
>
> Here's my slabinfo:
>
>  Active / Total Objects (% used)    : 83818306 / 84191607 (99.6%)
>  Active / Total Slabs (% used)      : 1336293 / 1336293 (100.0%)
>  Active / Total Caches (% used)     : 152 / 217 (70.0%)
>  Active / Total Size (% used)       : 5828768.08K / 5996848.72K (97.2%)
>  Minimum / Average / Maximum Object : 0.01K / 0.07K / 23.25K
>
>   OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
>
> 80253888 80253888 100%    0.06K 1253967       64   5015868K iommu_iova
>
> 489472 489123  99%    0.03K   3824      128     15296K kmalloc-32
>
> 297444 271112  91%    0.19K   7082       42     56656K dentry
>
> 254400 252784  99%    0.06K   3975       64     15900K anon_vma_chain
>
> 222528  39255  17%    0.50K   6954       32    111264K kmalloc-512
>
> 202482 201814  99%    0.19K   4821       42     38568K vm_area_struct
>
> 200192 200192 100%    0.01K    391      512      1564K kmalloc-8
>
> 170528 169359  99%    0.25K   5329       32     42632K filp
>
> 158144 153508  97%    0.06K   2471       64      9884K kmalloc-64
>
> 149914 149365  99%    0.09K   3259       46     13036K anon_vma
>
> 146640 143123  97%    0.10K   3760       39     15040K buffer_head
>
> 130368  32791  25%    0.09K   3104       42     12416K kmalloc-96
>
> 129752 129752 100%    0.07K   2317       56      9268K Acpi-Operand
>
> 105468 105106  99%    0.04K   1034      102      4136K
> selinux_inode_security
>  73080  73080 100%    0.13K   2436       30      9744K kernfs_node_cache
>
>  72360  70261  97%    0.59K   1340       54     42880K inode_cache
>
>  71040  71040 100%    0.12K   2220       32      8880K eventpoll_epi
>
>  68096  59262  87%    0.02K    266      256      1064K kmalloc-16
>
>  53652  53652 100%    0.04K    526      102      2104K pde_opener
>
>  50496  31654  62%    2.00K   3156       16    100992K kmalloc-2048
>
>  46242  46242 100%    0.19K   1101       42      8808K cred_jar
>
>  44496  43013  96%    0.66K    927       48     29664K proc_inode_cache
>
>  44352  44352 100%    0.06K    693       64      2772K task_delay_info
>
>  43516  43471  99%    0.69K    946       46     30272K sock_inode_cache
>
>  37856  27626  72%    1.00K   1183       32     37856K kmalloc-1024
>
>  36736  36736 100%    0.07K    656       56      2624K eventpoll_pwq
>
>  34076  31282  91%    0.57K   1217       28     19472K radix_tree_node
>
>  33660  30528  90%    1.05K   1122       30     35904K ext4_inode_cache
>
>  32760  30959  94%    0.19K    780       42      6240K kmalloc-192
>
>  32028  32028 100%    0.04K    314      102      1256K ext4_extent_status
>
>  30048  30048 100%    0.25K    939       32      7512K skbuff_head_cache
>
>  28736  28736 100%    0.06K    449       64      1796K fs_cache
>
>  24702  24702 100%    0.69K    537       46     17184K files_cache
>
>  23808  23808 100%    0.66K    496       48     15872K ovl_inode
>
>  23104  22945  99%    0.12K    722       32      2888K kmalloc-128
>
>  22724  21307  93%    0.69K    494       46     15808K shmem_inode_cache
>
>  21472  21472 100%    0.12K    671       32      2684K seq_file
>
>  19904  19904 100%    1.00K    622       32     19904K UNIX
>
>  17340  17340 100%    1.06K    578       30     18496K mm_struct
>
>  15980  15980 100%    0.02K     94      170       376K avtab_node
>
>  14070  14070 100%    1.06K    469       30     15008K signal_cache
>
>  13248  13248 100%    0.12K    414       32      1656K pid
>
>  12128  11777  97%    0.25K    379       32      3032K kmalloc-256
>
>  11008  11008 100%    0.02K     43      256       172K
> selinux_file_security
>  10812  10812 100%    0.04K    106      102       424K Acpi-Namespace
>
> These information shows that the 'iommu_iova' is the top memory consumer.
> In order to optimize the network performence of Openstack virtual machine=
s,
> I enabled the vt-d feature in bios and sriov feature of Intel 82599 10G
> NIC. I'm assuming this is the root cause of this issue.
>
> Is there anything I can do to fix it?
>

--00000000000014ffcd05a3f1ad18
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+Rm9yZ2V0IHRvIG1lbnRpb24sIEkmIzM5O3ZlIGFscmVhZHkgZGlzYWJs
ZWQgdGhlIHNsYWIgbWVyZ2UsIHNvIHRoaXMgaXMgd2hhdCBpdCBpcy48L2Rpdj48YnI+PGRpdiBj
bGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5CaW4g
Jmx0OzxhIGhyZWY9Im1haWx0bzphbm9sZTE5NDlAZ21haWwuY29tIj5hbm9sZTE5NDlAZ21haWwu
Y29tPC9hPiZndDsg5LqOMjAyMOW5tDTmnIgyM+aXpeWRqOWbmyDkuIvljYg1OjEx5YaZ6YGT77ya
PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjow
cHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtw
YWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj5IZXksIGd1eXM6PGRpdj48YnI+PC9kaXY+
PGRpdj5JJiMzOTttIHJ1bm5pbmcgYSBiYXRjaCBvZiBDb3JlT1MgYm94ZXMsIHRoZSBsc2JfcmVs
ZWFzZSBpczo8YnI+PGJyPmBgYDxicj4jIGNhdCAvZXRjL2xzYi1yZWxlYXNlPGJyPkRJU1RSSUJf
SUQ9JnF1b3Q7Q29udGFpbmVyIExpbnV4IGJ5IENvcmVPUyZxdW90Ozxicj5ESVNUUklCX1JFTEVB
U0U9MjMwMy4zLjA8YnI+RElTVFJJQl9DT0RFTkFNRT0mcXVvdDtSaHlvbGl0ZSZxdW90Ozxicj5E
SVNUUklCX0RFU0NSSVBUSU9OPSZxdW90O0NvbnRhaW5lciBMaW51eCBieSBDb3JlT1MgMjMwMy4z
LjAgKFJoeW9saXRlKSZxdW90Ozxicj5gYGA8YnI+PGJyPmBgYDxicj4jIHVuYW1lIC1hPGJyPkxp
bnV4IGNsb3VkLXdvcmtlci0yNSA0LjE5Ljg2LWNvcmVvcyAjMSBTTVAgTW9uIERlYyAyIDIwOjEz
OjM4IC0wMCAyMDE5PGJyPng4Nl82NCBJbnRlbChSKSBYZW9uKFIpIENQVSBFNS0yNjQwIHYyIEAg
Mi4wMEdIeiBHZW51aW5lSW50ZWwgR05VL0xpbnV4PGJyPmBgYDxicj5SZWNlbnRseSwgSSBmb3Vu
ZCBteSB2bXMgY29uc3RlbnRseSBiZWluZyBraWxsZWQgZHVlIHRvIE9PTSwgYW5kIGFmdGVyPGJy
PmRpZ2dpbmcgaW50byB0aGUgcHJvYmxlbSwgSSBmaW5hbGx5IHJlYWxpemVkIHRoYXQgdGhlIGtl
cm5lbCBpcyBsZWFraW5nPGJyPm1lbW9yeS48YnI+PGJyPkhlcmUmIzM5O3MgbXkgc2xhYmluZm86
PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+wqBBY3RpdmUgLyBUb3RhbCBPYmplY3RzICgl
IHVzZWQpIMKgIMKgOiA4MzgxODMwNiAvIDg0MTkxNjA3ICg5OS42JSk8YnI+wqBBY3RpdmUgLyBU
b3RhbCBTbGFicyAoJSB1c2VkKSDCoCDCoCDCoDogMTMzNjI5MyAvIDEzMzYyOTMgKDEwMC4wJSk8
YnI+wqBBY3RpdmUgLyBUb3RhbCBDYWNoZXMgKCUgdXNlZCkgwqAgwqAgOiAxNTIgLyAyMTcgKDcw
LjAlKTxicj7CoEFjdGl2ZSAvIFRvdGFsIFNpemUgKCUgdXNlZCkgwqAgwqAgwqAgOiA1ODI4NzY4
LjA4SyAvIDU5OTY4NDguNzJLICg5Ny4yJSk8YnI+wqBNaW5pbXVtIC8gQXZlcmFnZSAvIE1heGlt
dW0gT2JqZWN0IDogMC4wMUsgLyAwLjA3SyAvIDIzLjI1Szxicj48YnI+wqAgT0JKUyBBQ1RJVkUg
wqBVU0UgT0JKIFNJWkUgwqBTTEFCUyBPQkovU0xBQiBDQUNIRSBTSVpFIE5BTUUgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgPGJyPjgwMjUzODg4IDgwMjUzODg4IDEwMCUgwqAgwqAwLjA2SyAx
MjUzOTY3IMKgIMKgIMKgIDY0IMKgIDUwMTU4NjhLIGlvbW11X2lvdmEgwqAgwqAgwqAgwqAgwqAg
wqAgPGJyPjQ4OTQ3MiA0ODkxMjMgwqA5OSUgwqAgwqAwLjAzSyDCoCAzODI0IMKgIMKgIMKgMTI4
IMKgIMKgIDE1Mjk2SyBrbWFsbG9jLTMyIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4yOTc0NDQgMjcx
MTEyIMKgOTElIMKgIMKgMC4xOUsgwqAgNzA4MiDCoCDCoCDCoCA0MiDCoCDCoCA1NjY1NksgZGVu
dHJ5IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4yNTQ0MDAgMjUyNzg0IMKgOTklIMKgIMKg
MC4wNksgwqAgMzk3NSDCoCDCoCDCoCA2NCDCoCDCoCAxNTkwMEsgYW5vbl92bWFfY2hhaW4gwqAg
wqAgwqAgwqAgPGJyPjIyMjUyOCDCoDM5MjU1IMKgMTclIMKgIMKgMC41MEsgwqAgNjk1NCDCoCDC
oCDCoCAzMiDCoCDCoDExMTI2NEsga21hbGxvYy01MTIgwqAgwqAgwqAgwqAgwqAgwqA8YnI+MjAy
NDgyIDIwMTgxNCDCoDk5JSDCoCDCoDAuMTlLIMKgIDQ4MjEgwqAgwqAgwqAgNDIgwqAgwqAgMzg1
NjhLIHZtX2FyZWFfc3RydWN0IMKgIMKgIMKgIMKgIDxicj4yMDAxOTIgMjAwMTkyIDEwMCUgwqAg
wqAwLjAxSyDCoCDCoDM5MSDCoCDCoCDCoDUxMiDCoCDCoCDCoDE1NjRLIGttYWxsb2MtOCDCoCDC
oCDCoCDCoCDCoCDCoCDCoDxicj4xNzA1MjggMTY5MzU5IMKgOTklIMKgIMKgMC4yNUsgwqAgNTMy
OSDCoCDCoCDCoCAzMiDCoCDCoCA0MjYzMksgZmlscCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCA8YnI+MTU4MTQ0IDE1MzUwOCDCoDk3JSDCoCDCoDAuMDZLIMKgIDI0NzEgwqAgwqAgwqAgNjQg
wqAgwqAgwqA5ODg0SyBrbWFsbG9jLTY0IMKgIMKgIMKgIMKgIMKgIMKgIDxicj4xNDk5MTQgMTQ5
MzY1IMKgOTklIMKgIMKgMC4wOUsgwqAgMzI1OSDCoCDCoCDCoCA0NiDCoCDCoCAxMzAzNksgYW5v
bl92bWEgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPjE0NjY0MCAxNDMxMjMgwqA5NyUgwqAgwqAw
LjEwSyDCoCAzNzYwIMKgIMKgIMKgIDM5IMKgIMKgIDE1MDQwSyBidWZmZXJfaGVhZCDCoCDCoCDC
oCDCoCDCoCDCoDxicj4xMzAzNjggwqAzMjc5MSDCoDI1JSDCoCDCoDAuMDlLIMKgIDMxMDQgwqAg
wqAgwqAgNDIgwqAgwqAgMTI0MTZLIGttYWxsb2MtOTYgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPjEy
OTc1MiAxMjk3NTIgMTAwJSDCoCDCoDAuMDdLIMKgIDIzMTcgwqAgwqAgwqAgNTYgwqAgwqAgwqA5
MjY4SyBBY3BpLU9wZXJhbmQgwqAgwqAgwqAgwqAgwqAgPGJyPjEwNTQ2OCAxMDUxMDYgwqA5OSUg
wqAgwqAwLjA0SyDCoCAxMDM0IMKgIMKgIMKgMTAyIMKgIMKgIMKgNDEzNksgc2VsaW51eF9pbm9k
ZV9zZWN1cml0eSA8YnI+wqA3MzA4MCDCoDczMDgwIDEwMCUgwqAgwqAwLjEzSyDCoCAyNDM2IMKg
IMKgIMKgIDMwIMKgIMKgIMKgOTc0NEsga2VybmZzX25vZGVfY2FjaGUgwqAgwqAgwqA8YnI+wqA3
MjM2MCDCoDcwMjYxIMKgOTclIMKgIMKgMC41OUsgwqAgMTM0MCDCoCDCoCDCoCA1NCDCoCDCoCA0
Mjg4MEsgaW5vZGVfY2FjaGUgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqA3MTA0MCDCoDcxMDQwIDEw
MCUgwqAgwqAwLjEySyDCoCAyMjIwIMKgIMKgIMKgIDMyIMKgIMKgIMKgODg4MEsgZXZlbnRwb2xs
X2VwaSDCoCDCoCDCoCDCoCDCoDxicj7CoDY4MDk2IMKgNTkyNjIgwqA4NyUgwqAgwqAwLjAySyDC
oCDCoDI2NiDCoCDCoCDCoDI1NiDCoCDCoCDCoDEwNjRLIGttYWxsb2MtMTYgwqAgwqAgwqAgwqAg
wqAgwqAgPGJyPsKgNTM2NTIgwqA1MzY1MiAxMDAlIMKgIMKgMC4wNEsgwqAgwqA1MjYgwqAgwqAg
wqAxMDIgwqAgwqAgwqAyMTA0SyBwZGVfb3BlbmVyIMKgIMKgIMKgIMKgIMKgIMKgIDxicj7CoDUw
NDk2IMKgMzE2NTQgwqA2MiUgwqAgwqAyLjAwSyDCoCAzMTU2IMKgIMKgIMKgIDE2IMKgIMKgMTAw
OTkySyBrbWFsbG9jLTIwNDggwqAgwqAgwqAgwqAgwqAgPGJyPsKgNDYyNDIgwqA0NjI0MiAxMDAl
IMKgIMKgMC4xOUsgwqAgMTEwMSDCoCDCoCDCoCA0MiDCoCDCoCDCoDg4MDhLIGNyZWRfamFyIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIDxicj7CoDQ0NDk2IMKgNDMwMTMgwqA5NiUgwqAgwqAwLjY2SyDC
oCDCoDkyNyDCoCDCoCDCoCA0OCDCoCDCoCAyOTY2NEsgcHJvY19pbm9kZV9jYWNoZSDCoCDCoCDC
oCA8YnI+wqA0NDM1MiDCoDQ0MzUyIDEwMCUgwqAgwqAwLjA2SyDCoCDCoDY5MyDCoCDCoCDCoCA2
NCDCoCDCoCDCoDI3NzJLIHRhc2tfZGVsYXlfaW5mbyDCoCDCoCDCoCDCoDxicj7CoDQzNTE2IMKg
NDM0NzEgwqA5OSUgwqAgwqAwLjY5SyDCoCDCoDk0NiDCoCDCoCDCoCA0NiDCoCDCoCAzMDI3Mksg
c29ja19pbm9kZV9jYWNoZSDCoCDCoCDCoCA8YnI+wqAzNzg1NiDCoDI3NjI2IMKgNzIlIMKgIMKg
MS4wMEsgwqAgMTE4MyDCoCDCoCDCoCAzMiDCoCDCoCAzNzg1Nksga21hbGxvYy0xMDI0IMKgIMKg
IMKgIMKgIMKgIDxicj7CoDM2NzM2IMKgMzY3MzYgMTAwJSDCoCDCoDAuMDdLIMKgIMKgNjU2IMKg
IMKgIMKgIDU2IMKgIMKgIMKgMjYyNEsgZXZlbnRwb2xsX3B3cSDCoCDCoCDCoCDCoCDCoDxicj7C
oDM0MDc2IMKgMzEyODIgwqA5MSUgwqAgwqAwLjU3SyDCoCAxMjE3IMKgIMKgIMKgIDI4IMKgIMKg
IDE5NDcySyByYWRpeF90cmVlX25vZGUgwqAgwqAgwqAgwqA8YnI+wqAzMzY2MCDCoDMwNTI4IMKg
OTAlIMKgIMKgMS4wNUsgwqAgMTEyMiDCoCDCoCDCoCAzMCDCoCDCoCAzNTkwNEsgZXh0NF9pbm9k
ZV9jYWNoZSDCoCDCoCDCoCA8YnI+wqAzMjc2MCDCoDMwOTU5IMKgOTQlIMKgIMKgMC4xOUsgwqAg
wqA3ODAgwqAgwqAgwqAgNDIgwqAgwqAgwqA2MjQwSyBrbWFsbG9jLTE5MiDCoCDCoCDCoCDCoCDC
oCDCoDxicj7CoDMyMDI4IMKgMzIwMjggMTAwJSDCoCDCoDAuMDRLIMKgIMKgMzE0IMKgIMKgIMKg
MTAyIMKgIMKgIMKgMTI1NksgZXh0NF9leHRlbnRfc3RhdHVzIMKgIMKgIDxicj7CoDMwMDQ4IMKg
MzAwNDggMTAwJSDCoCDCoDAuMjVLIMKgIMKgOTM5IMKgIMKgIMKgIDMyIMKgIMKgIMKgNzUxMksg
c2tidWZmX2hlYWRfY2FjaGUgwqAgwqAgwqA8YnI+wqAyODczNiDCoDI4NzM2IDEwMCUgwqAgwqAw
LjA2SyDCoCDCoDQ0OSDCoCDCoCDCoCA2NCDCoCDCoCDCoDE3OTZLIGZzX2NhY2hlIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIDxicj7CoDI0NzAyIMKgMjQ3MDIgMTAwJSDCoCDCoDAuNjlLIMKgIMKgNTM3
IMKgIMKgIMKgIDQ2IMKgIMKgIDE3MTg0SyBmaWxlc19jYWNoZSDCoCDCoCDCoCDCoCDCoCDCoDxi
cj7CoDIzODA4IMKgMjM4MDggMTAwJSDCoCDCoDAuNjZLIMKgIMKgNDk2IMKgIMKgIMKgIDQ4IMKg
IMKgIDE1ODcySyBvdmxfaW5vZGUgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAyMzEwNCDCoDIy
OTQ1IMKgOTklIMKgIMKgMC4xMksgwqAgwqA3MjIgwqAgwqAgwqAgMzIgwqAgwqAgwqAyODg4SyBr
bWFsbG9jLTEyOCDCoCDCoCDCoCDCoCDCoCDCoDxicj7CoDIyNzI0IMKgMjEzMDcgwqA5MyUgwqAg
wqAwLjY5SyDCoCDCoDQ5NCDCoCDCoCDCoCA0NiDCoCDCoCAxNTgwOEsgc2htZW1faW5vZGVfY2Fj
aGUgwqAgwqAgwqA8YnI+wqAyMTQ3MiDCoDIxNDcyIDEwMCUgwqAgwqAwLjEySyDCoCDCoDY3MSDC
oCDCoCDCoCAzMiDCoCDCoCDCoDI2ODRLIHNlcV9maWxlIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxi
cj7CoDE5OTA0IMKgMTk5MDQgMTAwJSDCoCDCoDEuMDBLIMKgIMKgNjIyIMKgIMKgIMKgIDMyIMKg
IMKgIDE5OTA0SyBVTklYIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj7CoDE3MzQwIMKg
MTczNDAgMTAwJSDCoCDCoDEuMDZLIMKgIMKgNTc4IMKgIMKgIMKgIDMwIMKgIMKgIDE4NDk2SyBt
bV9zdHJ1Y3QgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAxNTk4MCDCoDE1OTgwIDEwMCUgwqAg
wqAwLjAySyDCoCDCoCA5NCDCoCDCoCDCoDE3MCDCoCDCoCDCoCAzNzZLIGF2dGFiX25vZGUgwqAg
wqAgwqAgwqAgwqAgwqAgPGJyPsKgMTQwNzAgwqAxNDA3MCAxMDAlIMKgIMKgMS4wNksgwqAgwqA0
NjkgwqAgwqAgwqAgMzAgwqAgwqAgMTUwMDhLIHNpZ25hbF9jYWNoZSDCoCDCoCDCoCDCoCDCoCA8
YnI+wqAxMzI0OCDCoDEzMjQ4IDEwMCUgwqAgwqAwLjEySyDCoCDCoDQxNCDCoCDCoCDCoCAzMiDC
oCDCoCDCoDE2NTZLIHBpZCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj7CoDEyMTI4
IMKgMTE3NzcgwqA5NyUgwqAgwqAwLjI1SyDCoCDCoDM3OSDCoCDCoCDCoCAzMiDCoCDCoCDCoDMw
MzJLIGttYWxsb2MtMjU2IMKgIMKgIMKgIMKgIMKgIMKgPGJyPsKgMTEwMDggwqAxMTAwOCAxMDAl
IMKgIMKgMC4wMksgwqAgwqAgNDMgwqAgwqAgwqAyNTYgwqAgwqAgwqAgMTcySyBzZWxpbnV4X2Zp
bGVfc2VjdXJpdHkgwqA8YnI+wqAxMDgxMiDCoDEwODEyIDEwMCUgwqAgwqAwLjA0SyDCoCDCoDEw
NiDCoCDCoCDCoDEwMiDCoCDCoCDCoCA0MjRLIEFjcGktTmFtZXNwYWNlwqAgwqAgwqA8YnI+PC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGVzZSBpbmZvcm1hdGlvbiBzaG93cyB0aGF0IHRoZSAm
IzM5O2lvbW11X2lvdmEmIzM5OyBpcyB0aGUgdG9wIG1lbW9yeSBjb25zdW1lci4gSW4gb3JkZXIg
dG8gb3B0aW1pemUgdGhlIG5ldHdvcmsgcGVyZm9ybWVuY2Ugb2YgT3BlbnN0YWNrIHZpcnR1YWwg
bWFjaGluZXMsIEkgZW5hYmxlZCB0aGUgdnQtZCBmZWF0dXJlIGluIGJpb3MgYW5kIHNyaW92IGZl
YXR1cmUgb2YgSW50ZWwgODI1OTkgMTBHIE5JQy4gSSYjMzk7bSBhc3N1bWluZyB0aGlzIGlzIHRo
ZSByb290IGNhdXNlIG9mIHRoaXMgaXNzdWUuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JcyB0
aGVyZSBhbnl0aGluZyBJIGNhbiBkbyB0byBmaXggaXQ/PC9kaXY+PC9kaXY+DQo8L2Jsb2NrcXVv
dGU+PC9kaXY+DQo=
--00000000000014ffcd05a3f1ad18--

--===============5861730166343398992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5861730166343398992==--
