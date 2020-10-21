Return-Path: <SRS0=cHqw=D4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F52C388F9
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 21:35:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 894D624178
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 21:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X6zMf9Xi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 894D624178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CF9D82E41F;
	Wed, 21 Oct 2020 21:35:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UibhwWw74lia; Wed, 21 Oct 2020 21:34:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 84A492E65C;
	Wed, 21 Oct 2020 15:29:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F079C088B;
	Wed, 21 Oct 2020 15:29:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBC13C0051
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 15:29:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C9B6B87019
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 15:29:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0iI9af+wBv1U for <iommu@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 15:29:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D1C9E86FC3
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 15:29:15 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09LF8qWh058622;
 Wed, 21 Oct 2020 15:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=B7vBvfn8227zOvfWtf1187wJychX5h3pcBxw5mG5iYY=;
 b=X6zMf9Xi2Nhtuztf53wsLdasGvRSaNrdSwtdk0H5jxCIp7uGXo5xlPJWX1r7M4AuZuLD
 Iqyx98UMniAE5riHIMSf59eu/Im4D4CEVKzGyvFzCO3nbqaIc5/z0kxzbB3JUbOe+eoP
 52fCf1sMcPZojl3fU4aVvno8NFXr+lbkxH0wsSGtSqeiuCQfsrzqEPljqHKjA5HR5dDR
 1fztRgqDS/MrP4K1UMRheNCz8ggVQiMt5SC+hbIrgj3+xn7GnRmb7IDtYVylS7MEF5Fq
 9G1xpuUENS4IlNSoXuRgw3gJ+7YAHFiLNgLSR/r+gB4K75agxGEVmLGVmWSK7/Rg5BFn sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 349jrps9ev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 21 Oct 2020 15:28:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09LF9u6s011436;
 Wed, 21 Oct 2020 15:28:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 34ak18syk3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Oct 2020 15:28:53 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09LFSdnw002429;
 Wed, 21 Oct 2020 15:28:39 GMT
Received: from tomti.i.net-space.pl (/10.175.162.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 21 Oct 2020 08:28:38 -0700
Date: Wed, 21 Oct 2020 17:28:33 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
To: Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH 07/13] x86: Secure Launch kernel early boot stub
Message-ID: <20201021152833.b3oys643ckcl5evq@tomti.i.net-space.pl>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <1600959521-24158-8-git-send-email-ross.philipson@oracle.com>
 <20200924173801.GA103726@rani.riverdale.lan>
 <c9ab2edf-1aaf-a1c9-92d5-2d37382a3163@oracle.com>
 <20200925191842.GA643740@rani.riverdale.lan>
 <d34c189c-4528-0458-0b84-cfd36dc068b3@oracle.com>
 <20201015182654.lgtht5fd2aaunczu@tomti.i.net-space.pl>
 <20201016205151.GA1618249@rani.riverdale.lan>
 <20201019145153.7b6cg3rzj7g4njz6@tomti.i.net-space.pl>
 <20201019171822.GD2701355@rani.riverdale.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201019171822.GD2701355@rani.riverdale.lan>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9780
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010210114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9780
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010210114
Cc: linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
 Ross Philipson <ross.philipson@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, luto@amacapital.net,
 iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, linux-integrity@vger.kernel.org,
 trenchboot-devel@googlegroups.com, tglx@linutronix.de
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

On Mon, Oct 19, 2020 at 01:18:22PM -0400, Arvind Sankar wrote:
> On Mon, Oct 19, 2020 at 04:51:53PM +0200, Daniel Kiper wrote:
> > On Fri, Oct 16, 2020 at 04:51:51PM -0400, Arvind Sankar wrote:
> > > On Thu, Oct 15, 2020 at 08:26:54PM +0200, Daniel Kiper wrote:
> > > >
> > > > I am discussing with Ross the other option. We can create
> > > > .rodata.mle_header section and put it at fixed offset as
> > > > kernel_info is. So, we would have, e.g.:
> > > >
> > > > arch/x86/boot/compressed/vmlinux.lds.S:
> > > >         .rodata.kernel_info KERNEL_INFO_OFFSET : {
> > > >                 *(.rodata.kernel_info)
> > > >         }
> > > >         ASSERT(ABSOLUTE(kernel_info) == KERNEL_INFO_OFFSET, "kernel_info at bad address!")
> > > >
> > > >         .rodata.mle_header MLE_HEADER_OFFSET : {
> > > >                 *(.rodata.mle_header)
> > > >         }
> > > >         ASSERT(ABSOLUTE(mle_header) == MLE_HEADER_OFFSET, "mle_header at bad address!")
> > > >
> > > > arch/x86/boot/compressed/sl_stub.S:
> > > > #define mleh_rva(X) (((X) - mle_header) + MLE_HEADER_OFFSET)
> > > >
> > > >         .section ".rodata.mle_header", "a"
> > > >
> > > > SYM_DATA_START(mle_header)
> > > >         .long   0x9082ac5a    /* UUID0 */
> > > >         .long   0x74a7476f    /* UUID1 */
> > > >         .long   0xa2555c0f    /* UUID2 */
> > > >         .long   0x42b651cb    /* UUID3 */
> > > >         .long   0x00000034    /* MLE header size */
> > > >         .long   0x00020002    /* MLE version 2.2 */
> > > >         .long   mleh_rva(sl_stub_entry)    /* Linear entry point of MLE (virt. address) */
> > > >         .long   0x00000000    /* First valid page of MLE */
> > > >         .long   0x00000000    /* Offset within binary of first byte of MLE */
> > > >         .long   0x00000000    /* Offset within binary of last byte + 1 of MLE */
> > > >         .long   0x00000223    /* Bit vector of MLE-supported capabilities */
> > > >         .long   0x00000000    /* Starting linear address of command line (unused) */
> > > >         .long   0x00000000    /* Ending linear address of command line (unused) */
> > > > SYM_DATA_END(mle_header)
> > > >
> > > > Of course MLE_HEADER_OFFSET has to be defined as a constant somewhere.
> > > > Anyway, is it acceptable?
> >
> > What do you think about my MLE_HEADER_OFFSET and related stuff proposal?
> >
>
> I'm wondering if it would be easier to just allow relocations in these
> special "header" sections. I need to check how easy/hard it is to do
> that without triggering linker warnings.

Ross and I still bouncing some ideas. We came to the conclusion that
putting mle_header into kernel .rodata.kernel_info section or even
arch/x86/boot/compressed/kernel_info.S file would be the easiest thing
to do at this point. Of course I would suggest some renaming too. E.g.
.rodata.kernel_info to .rodata.kernel_headers, etc. Does it make sense
for you?

Daniel
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
