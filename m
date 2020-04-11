Return-Path: <SRS0=UjaL=53=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C0CC2BBC7
	for <iommu@archiver.kernel.org>; Sat, 11 Apr 2020 05:52:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6243A20936
	for <iommu@archiver.kernel.org>; Sat, 11 Apr 2020 05:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6243A20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3568786917;
	Sat, 11 Apr 2020 05:52:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a6qJsTuEAyUC; Sat, 11 Apr 2020 05:52:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 81D5C868E5;
	Sat, 11 Apr 2020 05:52:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65161C1831;
	Sat, 11 Apr 2020 05:52:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65AF8C0177
 for <iommu@lists.linux-foundation.org>; Sat, 11 Apr 2020 05:52:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 32C2020499
 for <iommu@lists.linux-foundation.org>; Sat, 11 Apr 2020 05:52:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3pCmB6vizCKp for <iommu@lists.linux-foundation.org>;
 Sat, 11 Apr 2020 05:52:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by silver.osuosl.org (Postfix) with ESMTPS id F26B82045A
 for <iommu@lists.linux-foundation.org>; Sat, 11 Apr 2020 05:52:33 +0000 (UTC)
IronPort-SDR: QxF0HYuwCT0dH83ScwPUDNxZpGrRZqrxa5JdxV+aMTJsf2aLXINpv2s89B2W7fSDQU5RcuKVjk
 ubYLDxMU6qRg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2020 22:52:33 -0700
IronPort-SDR: D9S4NmhTY9He0vCHWlIIHDwfxarPdFygWdKBlgYxYMAyjMca3hoZdN6fUp+96mF+lgTf32YNKh
 C3aiBL+vOCkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,368,1580803200"; d="scan'208";a="287382593"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga002.fm.intel.com with ESMTP; 10 Apr 2020 22:52:33 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 10 Apr 2020 22:52:33 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 10 Apr 2020 22:52:32 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.129]) with mapi id 14.03.0439.000;
 Sat, 11 Apr 2020 13:52:23 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v1 6/8] vfio/type1: Bind guest page tables to host
Thread-Topic: [PATCH v1 6/8] vfio/type1: Bind guest page tables to host
Thread-Index: AQHWAEUdkW8K+/kg/06c7098DvJyv6hlyxcAgA2TZEA=
Date: Sat, 11 Apr 2020 05:52:22 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A22AD8E@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-7-git-send-email-yi.l.liu@intel.com>
 <20200402135700.0da30021@w520.home>
In-Reply-To: <20200402135700.0da30021@w520.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, 
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun, Yi
 Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

Hi Alex,

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Friday, April 3, 2020 3:57 AM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Subject: Re: [PATCH v1 6/8] vfio/type1: Bind guest page tables to host
> 
> On Sun, 22 Mar 2020 05:32:03 -0700
> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> 
> > From: Liu Yi L <yi.l.liu@intel.com>
> >
> > VFIO_TYPE1_NESTING_IOMMU is an IOMMU type which is backed by
[...]
> > +/**
> > + * Unbind specific gpasid, caller of this function requires hold
> > + * vfio_iommu->lock
> > + */
> > +static long vfio_iommu_type1_do_guest_unbind(struct vfio_iommu *iommu,
> > +				struct iommu_gpasid_bind_data *gbind_data)
> > +{
> > +	return vfio_iommu_for_each_dev(iommu,
> > +				vfio_unbind_gpasid_fn, gbind_data);
> > +}
> > +
> > +static long vfio_iommu_type1_bind_gpasid(struct vfio_iommu *iommu,
> > +				struct iommu_gpasid_bind_data *gbind_data)
> > +{
> > +	int ret = 0;
> > +
> > +	mutex_lock(&iommu->lock);
> > +	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)) {
> > +		ret = -EINVAL;
> > +		goto out_unlock;
> > +	}
> > +
> > +	ret = vfio_iommu_for_each_dev(iommu,
> > +			vfio_bind_gpasid_fn, gbind_data);
> > +	/*
> > +	 * If bind failed, it may not be a total failure. Some devices
> > +	 * within the iommu group may have bind successfully. Although
> > +	 * we don't enable pasid capability for non-singletion iommu
> > +	 * groups, a unbind operation would be helpful to ensure no
> > +	 * partial binding for an iommu group.
> 
> Where was the non-singleton group restriction done, I missed that.
> 
> > +	 */
> > +	if (ret)
> > +		/*
> > +		 * Undo all binds that already succeeded, no need to
> > +		 * check the return value here since some device within
> > +		 * the group has no successful bind when coming to this
> > +		 * place switch.
> > +		 */
> > +		vfio_iommu_type1_do_guest_unbind(iommu, gbind_data);
> 
> However, the for_each_dev function stops when the callback function
> returns error, are we just assuming we stop at the same device as we
> faulted on the first time and that we traverse the same set of devices
> the second time?  It seems strange to me that unbind should be able to
> fail.

I think the code needs enhancement. Although one group per container
and one device per group is the most typical and desired case, but
the code here loops domains, groups, devices. It should be able to
unwind prior bind when the loop failed for a device. So I plan to do
below change for bind path.

list_for_each_entry(domain, &iommu->domain_list, next) {
	list_for_each_entry(group, &domain->group_list, next) {
		/*
		  * if bind failed on a certain device, should unbind prior successful
		  * bind iommu_group_for_each_dev() should be modified to take two
		  * callbacks, one for forward loop and one for reverse loop when failure
		  * happened. "return_upon_failure" indicates whether return upon failure
		  * during forward loop or not. If yes, iommu_group_for_each_dev() should
		  * unwind the prior bind in this iommu group before return.
		  */
		ret = iommu_group_for_each_dev(iommu_group, bind_gpasid_fn,
					unbind_gpasid_fn, data, return_upon_failure);
		if (ret)
			break;
	}
	if (ret) {
		/* unwind bindings with prior groups */
		list_for_each_entry_continue_reverse(group,
							&domain->group_list, next) {
			iommu_group_for_each_dev(iommu_group, unbind_gpasid_fn,
						NULL, data, ignore_intermediate_failure);
		}
		break;
	}
}

if (ret) {
	/* unwind bindings with prior domains */
	list_for_each_entry_continue_reverse(domain, &iommu->domain_list, next) {
		iommu_group_for_each_dev(iommu_group, unbind_gpasid_fn,
						NULL, data, ignore_intermediate_failure);
		}
	}
}

return ret;

Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
