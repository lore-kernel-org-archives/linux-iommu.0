Return-Path: <SRS0=gZYu=WK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF51C32753
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 17:43:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32FD8214DA
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 17:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FD8214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E956EBDC;
	Wed, 14 Aug 2019 17:43:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7FE16DB2
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 17:18:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com
	[148.163.143.35])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1059887E
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 17:18:17 +0000 (UTC)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x7EGvC4f020879; Wed, 14 Aug 2019 17:18:09 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
	by mx0b-002e3701.pphosted.com with ESMTP id 2ucm0vh8y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Wed, 14 Aug 2019 17:18:09 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net
	[16.208.49.245])
	by g9t5008.houston.hpe.com (Postfix) with ESMTP id 92E2768;
	Wed, 14 Aug 2019 17:18:07 +0000 (UTC)
Received: from hpe.com (teo-eag.americas.hpqcorp.net [10.33.152.10])
	by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 4CB6F45;
	Wed, 14 Aug 2019 17:18:06 +0000 (UTC)
Date: Wed, 14 Aug 2019 12:18:06 -0500
From: Dimitri Sivanich <sivanich@hpe.com>
To: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v3 hmm 04/11] misc/sgi-gru: use mmu_notifier_get/put for
	struct gru_mm_struct
Message-ID: <20190814171806.GA14680@hpe.com>
References: <20190806231548.25242-1-jgg@ziepe.ca>
	<20190806231548.25242-5-jgg@ziepe.ca> <20190808102556.GB648@lst.de>
	<20190814155830.GO13756@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190814155830.GO13756@mellanox.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-08-14_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=636 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1906280000 definitions=main-1908140158
X-Mailman-Approved-At: Wed, 14 Aug 2019 17:43:57 +0000
Cc: Andrea Arcangeli <aarcange@redhat.com>,
	"David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Andrea Righi <andrea@betterlinux.com>, Dimitri Sivanich <sivanich@hpe.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>, "Kuehling,
	Felix" <Felix.Kuehling@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	Christoph Hellwig <hch@lst.de>
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

On Wed, Aug 14, 2019 at 03:58:34PM +0000, Jason Gunthorpe wrote:
> On Thu, Aug 08, 2019 at 12:25:56PM +0200, Christoph Hellwig wrote:
> > Looks good,
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Dimitri, are you OK with this patch?
>

I think this looks OK.

Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
