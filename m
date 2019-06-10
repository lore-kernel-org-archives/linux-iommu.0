Return-Path: <SRS0=ZsFK=UJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED1DC31E41
	for <iommu@archiver.kernel.org>; Mon, 10 Jun 2019 16:07:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC30B206C3
	for <iommu@archiver.kernel.org>; Mon, 10 Jun 2019 16:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BxVvqXlA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC30B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6AE48CBC;
	Mon, 10 Jun 2019 16:07:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D32A8CB0
	for <iommu@lists.linux-foundation.org>;
	Mon, 10 Jun 2019 16:07:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2C024832
	for <iommu@lists.linux-foundation.org>;
	Mon, 10 Jun 2019 16:07:29 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x5AFwncJ187361; Mon, 10 Jun 2019 16:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2018-07-02;
	bh=eNbG4FRMDvCLri2Xlvltw/kdKx3VZBJXRKHPR6ne+lM=;
	b=BxVvqXlANKeOX+fjB2N/PreAznVEnr3SXL9Rb6Mxkzs3hxSdPFOSuXqS4fisqD1TDdTI
	wAR4o3NyutIdKLIJT2yXDjPX65O9dvatarut8gqqIQkbbAUs0mgHCeh0I39OWlgS9Cp4
	EdhzmYGnRQ/Be4x/298BA47lXZImNxVEK0M8pBECb32zgnksKK6B5V4nDiNqq9gK9dR1
	aavCatnU6z477jCKwCuYCzHRd04IMlji/HbX2vfdnYmmmROrp8LyCd38rKcCBqzg4XFR
	/J6GE4MLc/eHzr65eMU09KKV5dIA5Etzo3ZQpNlm+34k0H9kx6AZQWkRREsq/sJXAOgs
	bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 2t05nqfsag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2019 16:06:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x5AG4pfo091578; Mon, 10 Jun 2019 16:06:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3030.oracle.com with ESMTP id 2t04hxv15f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2019 16:06:43 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5AG6e4t023104;
	Mon, 10 Jun 2019 16:06:40 GMT
Received: from char.us.oracle.com (/10.152.32.25)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 10 Jun 2019 09:06:40 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
	id 3F9206A00FC; Mon, 10 Jun 2019 12:08:03 -0400 (EDT)
Date: Mon, 10 Jun 2019 12:08:03 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 6/9] iommu/vt-d: Check whether device requires bounce
	buffer
Message-ID: <20190610160802.GX28796@char.us.oracle.com>
References: <20190603011620.31999-1-baolu.lu@linux.intel.com>
	<20190603011620.31999-7-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190603011620.31999-7-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1906100109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1906100109
Cc: alan.cox@intel.com, Christoph Hellwig <hch@lst.de>,
	Stefano Stabellini <sstabellini@kernel.org>, ashok.raj@intel.com,
	Jonathan Corbet <corbet@lwn.net>, pengfei.xu@intel.com,
	Ingo Molnar <mingo@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, kevin.tian@intel.com,
	Steven Rostedt <rostedt@goodmis.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	mika.westerberg@linux.intel.com, Juergen Gross <jgross@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	jacob.jun.pan@intel.com, Robin Murphy <robin.murphy@arm.com>
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

On Mon, Jun 03, 2019 at 09:16:17AM +0800, Lu Baolu wrote:
> This adds a helper to check whether a device needs to
> use bounce buffer. It also provides a boot time option
> to disable the bounce buffer. Users can use this to
> prevent the iommu driver from using the bounce buffer
> for performance gain.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Tested-by: Xu Pengfei <pengfei.xu@intel.com>
> Tested-by: Mika Westerberg <mika.westerberg@intel.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 5 +++++
>  drivers/iommu/intel-iommu.c                     | 6 ++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 138f6664b2e2..65685c6e53e4 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1728,6 +1728,11 @@
>  			Note that using this option lowers the security
>  			provided by tboot because it makes the system
>  			vulnerable to DMA attacks.
> +		nobounce [Default off]
> +			Do not use the bounce buffer for untrusted devices like
> +			the Thunderbolt devices. This will treat the untrusted

My brain has sometimes a hard time parsing 'Not' and 'un'. Could this be:

	Disable bounce buffer for unstrusted devices ..?


And perhaps call it 'noswiotlb' ? Not everyone knows that SWIOTLB = bounce buffer.

> +			devices as the trusted ones, hence might expose security
> +			risks of DMA attacks.
>  
>  	intel_idle.max_cstate=	[KNL,HW,ACPI,X86]
>  			0	disables intel_idle and fall back on acpi_idle.
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 235837c50719..41439647f75d 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -371,6 +371,7 @@ static int dmar_forcedac;
>  static int intel_iommu_strict;
>  static int intel_iommu_superpage = 1;
>  static int iommu_identity_mapping;
> +static int intel_no_bounce;

intel_swiotlb_on = 1 ?

>  
>  #define IDENTMAP_ALL		1
>  #define IDENTMAP_GFX		2
> @@ -384,6 +385,8 @@ EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
>  static DEFINE_SPINLOCK(device_domain_lock);
>  static LIST_HEAD(device_domain_list);
>  
> +#define device_needs_bounce(d) (!intel_no_bounce && dev_is_untrusted(d))
> +
>  /*
>   * Iterate over elements in device_domain_list and call the specified
>   * callback @fn against each element.
> @@ -466,6 +469,9 @@ static int __init intel_iommu_setup(char *str)
>  			printk(KERN_INFO
>  				"Intel-IOMMU: not forcing on after tboot. This could expose security risk for tboot\n");
>  			intel_iommu_tboot_noforce = 1;
> +		} else if (!strncmp(str, "nobounce", 8)) {
> +			pr_info("Intel-IOMMU: No bounce buffer. This could expose security risks of DMA attacks\n");

Again, Intel-IOMMU: No SWIOTLB. T.. blah blah'

Asking for this as doing 'dmesg | grep SWIOTLB' will expose nicely all
the SWIOTLB invocations..

> +			intel_no_bounce = 1;
>  		}
>  
>  		str += strcspn(str, ",");
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
