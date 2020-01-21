Return-Path: <SRS0=p6pp=3K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDBBC2D0CE
	for <iommu@archiver.kernel.org>; Tue, 21 Jan 2020 20:55:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E14721734
	for <iommu@archiver.kernel.org>; Tue, 21 Jan 2020 20:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q4U19iIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E14721734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E9ADA86816;
	Tue, 21 Jan 2020 20:55:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mVPcpyMHtnDM; Tue, 21 Jan 2020 20:55:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9EBD786793;
	Tue, 21 Jan 2020 20:55:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 848FBC0176;
	Tue, 21 Jan 2020 20:55:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD7D8C0174
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 20:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D9E6886793
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 20:55:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qXBCzcWZbMP4 for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jan 2020 20:55:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 307F5867CC
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 20:55:09 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00LKhosb128897;
 Tue, 21 Jan 2020 20:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=097qPjqdtLQ/u66QFt3FxKMZ7mao/EVAbbQjFNVYa14=;
 b=Q4U19iIqSyGgLf5SGthY7IKajJE5vk6hjt4L/JH8/cr3D5Cx+68VRLb01YBXLrPSfHWH
 mzgi458Q12OJJJdqeJSV+b84dhCdlKDAd+/EnV1kVk9igTMpp2Xpgt8xaCvsBcJ0DsdX
 DrVCwfRhUnvozWJSLy8Nm1DpskaD3XpzR7Az56cup1Apu6WAJgkC10vX8dqL31+z/HPb
 yYEjSK3cu7Gyt/+P27HtBzgysZLYCNbk/xmQILMXDRb5x1dyXxNCoxo/gqeoKoRGwayp
 Ipg/bBGAm4qC61wXvW82vCX5U5GTeNwWh1l00O11cCGy02wscx0WoxY6SUF1xQI7VxsK 7Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2xkseufvcy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2020 20:54:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00LKiPUf139141;
 Tue, 21 Jan 2020 20:54:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2xnsj5bx6j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2020 20:54:11 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00LKs7er001986;
 Tue, 21 Jan 2020 20:54:07 GMT
Received: from Konrads-MacBook-Pro.local (/10.74.98.244)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 21 Jan 2020 12:54:07 -0800
Date: Tue, 21 Jan 2020 15:54:03 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v2] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20200121205403.GC75374@Konrads-MacBook-Pro.local>
References: <20191209231346.5602-1-Ashish.Kalra@amd.com>
 <20191220015245.GA7010@localhost.localdomain>
 <20200121200947.GA24884@ashkalra_ubuntu_server>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200121200947.GA24884@ashkalra_ubuntu_server>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9507
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001210156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9507
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001210156
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com, dave.hansen@linux-intel.com,
 peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
 luto@kernel.org, hpa@zytor.com, Konrad Rzeszutek Wilk <konrad@darnok.org>,
 tglx@linutronix.de, hch@lst.de
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

On Tue, Jan 21, 2020 at 08:09:47PM +0000, Ashish Kalra wrote:
> On Thu, Dec 19, 2019 at 08:52:45PM -0500, Konrad Rzeszutek Wilk wrote:
> > On Mon, Dec 09, 2019 at 11:13:46PM +0000, Ashish Kalra wrote:
> > > From: Ashish Kalra <ashish.kalra@amd.com>
> > > 
> > > For SEV, all DMA to and from guest has to use shared
> > > (un-encrypted) pages. SEV uses SWIOTLB to make this happen
> > > without requiring changes to device drivers. However,
> > > depending on workload being run, the default 64MB of SWIOTLB
> > > might not be enough and SWIOTLB may run out of buffers to
> > > use for DMA, resulting in I/O errors.
> > > 
> > > Increase the default size of SWIOTLB for SEV guests using
> > > a minimum value of 128MB and a maximum value of 512MB,
> > > determining on amount of provisioned guest memory.
> > > 
> > > The SWIOTLB default size adjustment is added as an
> > > architecture specific interface/callback to allow
> > > architectures such as those supporting memory encryption
> > > to adjust/expand SWIOTLB size for their use.
> > 
> > What if this was made dynamic? That is if there is a memory
> > pressure you end up expanding the SWIOTLB dynamically?
> 
> As of now we want to keep it as simple as possible and more
> like a stop-gap arrangement till something more elegant is
> available.

That is nice. But past experience has shown that stop-gap arrangments
end up being the defacto solution.

> 
> > 
> >> Also is it worth doing this calculation based on memory or
> >> more on the # of PCI devices + their MMIO ranges size?
> 
> Additional memory calculations based on # of PCI devices and
> their memory ranges will make it more complicated with so
> many other permutations and combinations to explore, it is
> essential to keep this patch as simple as possible by 
> adjusting the bounce buffer size simply by determining it
> from the amount of provisioned guest memory.

Please rework the patch to:

 - Use a log solution instead of the multiplication.
   Feel free to cap it at a sensible value.

 - Also the code depends on SWIOTLB calling in to the
   adjust_swiotlb_default_size which looks wrong.

   You should not adjust io_tlb_nslabs from swiotlb_size_or_default.
   That function's purpose is to report a value.

 - Make io_tlb_nslabs be visible outside of the SWIOTLB code.

 - Can you utilize the IOMMU_INIT APIs and have your own detect which would
   modify the io_tlb_nslabs (and set swiotbl=1?).

   Actually you seem to be piggybacking on pci_swiotlb_detect_4gb - so
   perhaps add in this code ? Albeit it really should be in it's own
   file, not in arch/x86/kernel/pci-swiotlb.c

 - Tweak the code in the swiotlb code to make sure it can deal
   with io_tlb_nslabs being modified outside of the code at
   the start. It should have no trouble, but only testing will
   tell for sure.

> 
> Thanks,
> Ashish
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
