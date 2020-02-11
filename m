Return-Path: <SRS0=3qjS=37=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DA7C352A3
	for <iommu@archiver.kernel.org>; Tue, 11 Feb 2020 15:24:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25FB20870
	for <iommu@archiver.kernel.org>; Tue, 11 Feb 2020 15:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mdcUuzxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25FB20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id ABAAB8786C;
	Tue, 11 Feb 2020 15:24:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id itOt2gdF3w-I; Tue, 11 Feb 2020 15:24:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 35B478763E;
	Tue, 11 Feb 2020 15:24:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BA5DC1D80;
	Tue, 11 Feb 2020 15:24:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 503E8C07FE
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 15:24:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3C1C680AD8
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 15:24:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OEe_IC9JwIH9 for <iommu@lists.linux-foundation.org>;
 Tue, 11 Feb 2020 15:24:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6490F85569
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 15:24:23 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01BFIMtn050776;
 Tue, 11 Feb 2020 15:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=rjU87+Ogly5E4HZfszDaugkhsgHbh9F4n3AxSdIaXms=;
 b=mdcUuzxoSwt1cdXEM93sf9MwLpjpCCwCwBW6hkLySMCkQ9Z3kCS2vTR+4gpvQz5foyEs
 oUzFlnuOaXcue+Bbx+heqp5ZwI/mL+yggNq41lw7rkOG9UQhSZBQbOH9ATGoD6/r27gK
 STNkwtfL4M/EBb/8wFUnWzJZ/a+s36zBSQ1SW+CnHi/5hLeCA4iY6Kaceo1HWZgKZDF3
 Bzd7l4+jgn5VqIagxNODPJm+sjfEBJHADHPcNTb1iBqHw4Yf70zSp45aOFQcYrff8afB
 vW4RCmgx2iA7a6VIjOlCz8Dd2sXd6QE0LD0ysaraRQIzaSU+n7UQ2NOrPJ+IwBNMilhO ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2y2k884251-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 11 Feb 2020 15:24:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01BFGcTs082321;
 Tue, 11 Feb 2020 15:24:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2y26q1fbv5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Feb 2020 15:24:18 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01BFOH3B020773;
 Tue, 11 Feb 2020 15:24:17 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 11 Feb 2020 07:24:17 -0800
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: AMD IOMMU stops RDMA NFS from working since kernel 5.5 (bisected)
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <ac758665-9127-9a52-4f03-49fecc5289a2@arm.com>
Date: Tue, 11 Feb 2020 10:24:16 -0500
Message-Id: <3507674A-F860-4B65-BD46-93431DD268AC@oracle.com>
References: <7ee099af-e6bb-18fe-eb93-2a8abd401570@tomt.net>
 <20200211072537.GD23114@suse.de>
 <2CE039F4-3519-4481-B0E2-840D24EE4428@oracle.com>
 <ac758665-9127-9a52-4f03-49fecc5289a2@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002110113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002110113
Cc: Tom Murphy <tmurphy@arista.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Joerg Roedel <jroedel@suse.de>, Andre Tomt <andre@tomt.net>,
 iommu@lists.linux-foundation.org
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



> On Feb 11, 2020, at 10:12 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> 
> On 11/02/2020 1:48 pm, Chuck Lever wrote:
>> Andre-
>> Thank you for the detailed report!
>> Tom-
>> There is a rich set of trace points available in the RPC/RDMA implementation in 5.4/5.5, fwiw.
>> Please keep me in the loop, let me know if there is anything I can do to help.
> 
> One aspect that may be worth checking is whether there's anywhere that assumes a successful return value from dma_map_sg() is always the same as the number of entries passed in - that's the most obvious way the iommu-dma code differs (legitimately) from the previous amd-iommu implementation.

net/sunrpc/xprtrdma/frwr_ops.c: frwr_map()

317         mr->mr_nents =
318                 ib_dma_map_sg(ia->ri_id->device, mr->mr_sg, i, mr->mr_dir);
319         if (!mr->mr_nents)
320                 goto out_dmamap_err;

Should that rather be "if (mr->mr_nents != i)" ?


> Robin.
> 
>>> On Feb 11, 2020, at 2:25 AM, Joerg Roedel <jroedel@suse.de> wrote:
>>> 
>>> Adding Tom's new email address.
>>> 
>>> Tom, can you have a look, please?
>>> https://bugzilla.kernel.org/show_bug.cgi?id=206461 seems to be a similar
>>> issue.
>>> 
>>> On Tue, Feb 11, 2020 at 06:06:54AM +0100, Andre Tomt wrote:
>>>> Since upgrading my RDMA lab from kernel 5.4.x to 5.5.x, NFSv4 over RDMA
>>>> stopped working. But only on my AMD Ryzen systems. And so far only NFS,
>>>> curiously other RDMA diagnostic tools (like qperf <ip> -cm1 rc_bw) work
>>>> fine.
>>>> 
>>>> A git bisect points to be62dbf554c5b50718a54a359372c148cd9975c7 iommu/amd:
>>>> Convert AMD iommu driver to the dma-iommu api
>>>> 
>>>> 5.5.3-rc1, 5.6-rc1 are also not working.
>>>> 
>>>> I verified it by booting with amd_iommu=off on the kernel cmdline - it makes
>>>> everything work again.
>>>> 
>>>> The NFS config is a pretty simple NFSv4.x only, sec=sys setup, running over
>>>> RoCEv1 on Mellanox mlx4 hardware (ConnectX-3 Pro, fw 2.42.5000). Nothing
>>>> fancy besides the RoCEv1 and related bits network bits like PFC and storage
>>>> VLAN. Bare metal, no virtualization.
>>>> 
>>>> The impacted systems are:
>>>> ASUS ROG STRIX X399-E GAMING, with a Threadripper 1950x, BIOS 1002
>>>> ASUS Pro WS X570-ACE, with a Ryzen 7 3700x, BIOS 1201
>>>> 
>>>> pcaps off a mirror port can be provided. They show that on 5.5.x, CM
>>>> succeeds, and then a couple of NFS NULL calls comes through (over RoCE),
>>>> both acked, and then the rest just never goes out from the client until the
>>>> mount times out and CM is torn down.
>>>> 
>>>> No messages shows up in the kernel log on either side. I was at least
>>>> expecting some scary IOMMU warnings.
>>>> 
>>>> More serious hardware is not available for RDMA testing currently, so I dont
>>>> know if a EPYC system or newer mlx5 cards would have similar issues. Intel
>>>> I've only tested as server so far, that worked fine, as expected given the
>>>> bisect result.
>>>> 
>>>> 
>>>>> git bisect start
>>>>> # bad: [d5226fa6dbae0569ee43ecfc08bdcd6770fc4755] Linux 5.5
>>>>> git bisect bad d5226fa6dbae0569ee43ecfc08bdcd6770fc4755
>>>>> # good: [219d54332a09e8d8741c1e1982f5eae56099de85] Linux 5.4
>>>>> git bisect good 219d54332a09e8d8741c1e1982f5eae56099de85
>>>>> # good: [8c39f71ee2019e77ee14f88b1321b2348db51820] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
>>>>> git bisect good 8c39f71ee2019e77ee14f88b1321b2348db51820
>>>>> # bad: [76bb8b05960c3d1668e6bee7624ed886cbd135ba] Merge tag 'kbuild-v5.5' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
>>>>> git bisect bad 76bb8b05960c3d1668e6bee7624ed886cbd135ba
>>>>> # good: [21b26d2679584c6a60e861aa3e5ca09a6bab0633] Merge tag '5.5-rc-smb3-fixes' of git://git.samba.org/sfrench/cifs-2.6
>>>>> git bisect good 21b26d2679584c6a60e861aa3e5ca09a6bab0633
>>>>> # good: [e5b3fc125d768eacd73bb4dc5019f0ce95635af4] Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>>> git bisect good e5b3fc125d768eacd73bb4dc5019f0ce95635af4
>>>>> # bad: [937d6eefc716a9071f0e3bada19200de1bb9d048] Merge tag 'docs-5.5a' of git://git.lwn.net/linux
>>>>> git bisect bad 937d6eefc716a9071f0e3bada19200de1bb9d048
>>>>> # bad: [1daa56bcfd8b329447e0c1b1e91c3925d08489b7] Merge tag 'iommu-updates-v5.5' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
>>>>> git bisect bad 1daa56bcfd8b329447e0c1b1e91c3925d08489b7
>>>>> # good: [937790699be9c8100e5358625e7dfa8b32bd33f2] mm/page_io.c: annotate refault stalls from swap_readpage
>>>>> git bisect good 937790699be9c8100e5358625e7dfa8b32bd33f2
>>>>> # good: [a5255bc31673c72e264d837cd13cd3085d72cb58] Merge tag 'dmaengine-5.5-rc1' of git://git.infradead.org/users/vkoul/slave-dma
>>>>> git bisect good a5255bc31673c72e264d837cd13cd3085d72cb58
>>>>> # good: [34d1b0895dbd10713c73615d8f532e78509e12d9] iommu/arm-smmu: Remove duplicate error message
>>>>> git bisect good 34d1b0895dbd10713c73615d8f532e78509e12d9
>>>>> # bad: [3c124435e8dd516df4b2fc983f4415386fd6edae] iommu/amd: Support multiple PCI DMA aliases in IRQ Remapping
>>>>> git bisect bad 3c124435e8dd516df4b2fc983f4415386fd6edae
>>>>> # bad: [be62dbf554c5b50718a54a359372c148cd9975c7] iommu/amd: Convert AMD iommu driver to the dma-iommu api
>>>>> git bisect bad be62dbf554c5b50718a54a359372c148cd9975c7
>>>>> # good: [781ca2de89bae1b1d2c96df9ef33e9a324415995] iommu: Add gfp parameter to iommu_ops::map
>>>>> git bisect good 781ca2de89bae1b1d2c96df9ef33e9a324415995
>>>>> # good: [6e2350207f40e24884da262976f7fd4fba387e8a] iommu/dma-iommu: Use the dev->coherent_dma_mask
>>>>> git bisect good 6e2350207f40e24884da262976f7fd4fba387e8a
>>>>> # first bad commit: [be62dbf554c5b50718a54a359372c148cd9975c7] iommu/amd: Convert AMD iommu driver to the dma-iommu api
>> --
>> Chuck Lever
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu

--
Chuck Lever



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
