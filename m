Return-Path: <SRS0=rqG6=XB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760AAC43331
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 14:41:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD0D206A5
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 14:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DOF557n5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD0D206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 03AD8242C;
	Fri,  6 Sep 2019 14:41:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 08D9423DA
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 14:41:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 98E68756
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 14:41:31 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x86Ed6m5079684; Fri, 6 Sep 2019 14:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2019-08-05;
	bh=y8TtBHLyh9FaXB7YWA2oSVkXqqAPTbDmmbDnNI16F7o=;
	b=DOF557n5O1G3LePDNwr0JmO+vUm1GxrH6KN/LwtR3hkP3O/j3iy8egyMpJJWrEE044Ms
	63u4oumZ8oks/ZQRt7gfi0pK7vIAlULQAqYOtlGhhrRO2AZGGB3aE1kS0SNn+hXG9h2j
	0e2sQGNUvzrsaDZFQ6WFwgwhQrFW5urHG0xRcT9U5UnygFZRpuhg1toZ5VtMpqbhEJdX
	KtuV4y/6mgxs7wmro5Da451nB8UjHcp+oaXbc6Bq5IEq+BnYuuiB0W22oulaN3NFJ5sQ
	nCF9axdCfZyMG1fkwd20WASjft3Kw2kS6qExeFXgNQ6OKHyjfNOrCMLbrU9vRwOEetaz
	OQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 2uus55048m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2019 14:41:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x86Ed28j110378; Fri, 6 Sep 2019 14:41:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3020.oracle.com with ESMTP id 2uum4h555m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2019 14:41:20 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x86EfIvV032549;
	Fri, 6 Sep 2019 14:41:18 GMT
Received: from char.us.oracle.com (/10.152.32.25)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 06 Sep 2019 07:41:17 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
	id BD96F6A00C1; Fri,  6 Sep 2019 10:43:00 -0400 (EDT)
Date: Fri, 6 Sep 2019 10:43:00 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 09/11] swiotlb-xen: simplify cache maintainance
Message-ID: <20190906144300.GD7824@char.us.oracle.com>
References: <20190905113408.3104-1-hch@lst.de>
	<20190905113408.3104-10-hch@lst.de>
	<e4f9b393-2631-57cd-f42f-3581e75ab9a3@oracle.com>
	<20190906140123.GA9894@lst.de>
	<ca88e7b8-08ca-51b2-0c77-c828d92da0db@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ca88e7b8-08ca-51b2-0c77-c828d92da0db@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9372
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=829
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1906280000 definitions=main-1909060155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9372
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=893
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
	definitions=main-1909060155
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	xen-devel@lists.xenproject.org, Christoph Hellwig <hch@lst.de>,
	linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Sep 06, 2019 at 10:19:01AM -0400, Boris Ostrovsky wrote:
> On 9/6/19 10:01 AM, Christoph Hellwig wrote:
> > On Fri, Sep 06, 2019 at 09:52:12AM -0400, Boris Ostrovsky wrote:
> >> We need nop definitions of these two for x86.
> >>
> >> Everything builds now but that's probably because the calls are under
> >> 'if (!dev_is_dma_coherent(dev))' which is always false so compiler
> >> optimized is out. I don't think we should rely on that.
> > That is how a lot of the kernel works.  Provide protypes only for code
> > that is semantically compiled, but can't ever be called due to
> > IS_ENABLED() checks.  It took me a while to get used to it, but it
> > actually is pretty nice as the linker does the work for you to check
> > that it really is never called.  Much better than say a BUILD_BUG_ON().
> 
> 
> (with corrected Juergen's email)
> 
> I know about IS_ENABLED() but I didn't realize that this is allowed for
> compile-time inlines and such as well.
> 
> Anyway, for non-ARM bits
> 
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

as well.

Albeit folks have tested this under x86 Xen with 'swiotlb=force' right?

I can test it myself but it will take a couple of days.
> 
> If this goes via Xen tree then the first couple of patches need an ack
> from ARM maintainers.
> 
> -boris
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
