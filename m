Return-Path: <SRS0=ytjs=7R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B24CC433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 14:21:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6BD4207D8
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 14:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G/YQjK5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BD4207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AFA9C86F7E;
	Thu,  4 Jun 2020 14:21:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5WXvJU9ER-aj; Thu,  4 Jun 2020 14:21:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 04E4C86F22;
	Thu,  4 Jun 2020 14:21:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA3DCC0888;
	Thu,  4 Jun 2020 14:21:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7257CC016E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 14:21:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3F7AF86F69
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 14:21:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mBRZpZvr6yQU for <iommu@lists.linux-foundation.org>;
 Thu,  4 Jun 2020 14:21:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8869C86F22
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 14:21:11 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054EITrc151364;
 Thu, 4 Jun 2020 14:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=b0Vwb9ltP6zvm2OSzzDEJ/vSNyb5B6vhoRMvKw75iP8=;
 b=G/YQjK5drB2XKrie1OBPI8YwUqZsoDv18FPoVpOOpmW1Tjzxd6CzXBg/s3vjcuIEW16g
 YVu2lZFckoznI62rHoOjNw71RyCuVgt3LsuVuAC5RbTvI0OkDjHAp3YagmxLiurB94n4
 idnn1+6GAk/h5Kwr3FzRESMdniPuw8wZu6cfIMeOouV7zFK/wLTApnHUkYWw4v32D8Vc
 6/IiHYEiSv7f3dTBjLrnsG2bHY/Vf3j9gTIdM+z0DAGL3O8xVyIHYHVKx0z5OQmYCiwD
 UghZOJ3G12QOLiXCEVA6dGt1tuSydSgexCpmamEc2ngpOrt7F0rdlzPaP/eqmJygomfq Zg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 31evvn1t7v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 04 Jun 2020 14:20:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054EHZQS075422;
 Thu, 4 Jun 2020 14:20:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 31ej10fchv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 04 Jun 2020 14:20:26 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 054EJun0001887;
 Thu, 4 Jun 2020 14:19:56 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 04 Jun 2020 07:19:55 -0700
Date: Thu, 4 Jun 2020 17:18:57 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH v3 09/13] device core: Introduce multiple dma pfn offsets
Message-ID: <20200604141857.GH22511@kadam>
References: <20200603192058.35296-1-james.quinlan@broadcom.com>
 <20200603192058.35296-10-james.quinlan@broadcom.com>
 <20200604110455.GO30374@kadam>
 <CA+-6iNyaL8izv5eHJyYkhwu9diPsqT0AD08UU_ECexNcdrT+jA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+-6iNyaL8izv5eHJyYkhwu9diPsqT0AD08UU_ECexNcdrT+jA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006040098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 cotscore=-2147483648 suspectscore=0
 phishscore=0 clxscore=1015 malwarescore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006040098
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rich Felker <dalias@libc.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 "open list:REMOTE PROCESSOR REMOTEPROC SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>,
 "open list:DRM DRIVERS FOR ALLWINNER A10" <dri-devel@lists.freedesktop.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Julien Grall <julien.grall@arm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Frank Rowand <frowand.list@gmail.com>, Christoph Hellwig <hch@lst.de>,
 "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Will Deacon <will@kernel.org>,
 "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 "open list:ACPI FOR ARM64 ACPI/arm64" <linux-acpi@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Ingo Molnar <mingo@redhat.com>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>,
 Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>,
 Ohad Ben-Cohen <ohad@wizery.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Yong Deng <yong.deng@magewell.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oliver Neukum <oneukum@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 open list <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Stefano Stabellini <sstabellini@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Sudeep Holla <sudeep.holla@arm.com>,
 "open list:ALLWINNER A10 CSI DRIVER" <linux-media@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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

On Thu, Jun 04, 2020 at 09:48:49AM -0400, Jim Quinlan wrote:
> > > +     r = devm_kcalloc(dev, 1, sizeof(struct dma_pfn_offset_region),
> > > +                      GFP_KERNEL);
> >
> > Use:    r = devm_kzalloc(dev, sizeof(*r), GFP_KERNEL);
> Will fix.
> 
> >
> >
> > > +     if (!r)
> > > +             return -ENOMEM;
> > > +
> > > +     r->uniform_offset = true;
> > > +     r->pfn_offset = pfn_offset;
> > > +
> > > +     return 0;
> > > +}
> >
> > This function doesn't seem to do anything useful.  Is part of it
> > missing?
> No, the uniform pfn offset is a special case.

Sorry, I wasn't clear.  We're talking about different things.  The code
does:

	r = devm_kzalloc(dev, sizeof(*r), GFP_KERNEL);
	if (!r)
		return -ENOMEM;

	r->uniform_offset = true;
	r->pfn_offset = pfn_offset;

	return 0;

The code allocates "r" and then doesn't save it anywhere so there is
no point.

regards,
dan carpenter

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
