Return-Path: <SRS0=ZMVL=GW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65EAC433E0
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 10:17:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78DA023110
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 10:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DA023110
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E94C4864D7;
	Tue, 19 Jan 2021 10:17:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ProhZhw4BkB; Tue, 19 Jan 2021 10:17:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0AD09861AB;
	Tue, 19 Jan 2021 10:17:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1B05C08A1;
	Tue, 19 Jan 2021 10:17:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59E43C013A
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 10:17:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 44E1F20108
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 10:17:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xXf5mJmGTYoO for <iommu@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 10:17:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by silver.osuosl.org (Postfix) with ESMTPS id 293F32002E
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 10:17:07 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id c127so731638wmf.5
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 02:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=UOCaNFGn8qpkTDzGnatAjkLM9ck0E2AazlgdK9gboJ4=;
 b=QD87Pn3W+Re5ufLbkWhCkzqvZ/+9A1VMq6Cpc2o9IIWv5cfzqzWOkTL/Of7gjH6EYk
 sxqbyCsM6OB5YZ2GXYGVcTpvFCAw11aiEGVETWqYHejTw+6yGH9f4A5TygoZoUk630FK
 WI1fDC7P8JWsRMBZTQZrTJ3jtmVxbu3jGVUD/wKwWfV4Yg+i0qClff+9ucTwjubdxCCt
 4CbcPfEnYDDMSjamXU2ldnJvncO76AwzxoFmiO87WMAGv5m6ZN+uTtM1OUgPnSz9/b4z
 W7iBp8uYw/0GU9TshvvnorexHM7uwECFb0GIz83iYFMSd/CsvbZyFUco+xZ/5PsH6GVe
 0wxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UOCaNFGn8qpkTDzGnatAjkLM9ck0E2AazlgdK9gboJ4=;
 b=ZngI7ttBpapmVum8kR29o/oqfo6QZvbRM5gXnMbhdXCxCvWD52MoCuMXJ3DUt0Y01j
 e+hByRVKSY0gHM3j3aR+o5bYA5+aNkjvQhMDek0hqCvaogeFIjNjLBtLw3US81gYyJ8C
 ONsbBQVh34VUIEqOCofEFnuUKyobsKqcvG4LyhDDtENzhwbhtyiyGBUxnXTQZ63kAn+Z
 QVjt4oSfPPk8C6OvNIM4VKFAm28jdM3isSpKk9wPks9pdlAFO/OsRo7WBpUDVzPN+1nG
 b/9biLgmspM+0CJ8FFzrZpj3D8ofBx+00N2m9l8Gk7tp+gfE8BZMzZ7FNU2UrqSzVCUm
 /uww==
X-Gm-Message-State: AOAM530MU24JfP5l7vBYLKMNOeWPyP2G5CVUMBUI8SYNBFgmIjei/ObL
 0ic+7KfD+t34YqIsyPUJaXCv4g==
X-Google-Smtp-Source: ABdhPJwi964FZpWtpaHGKGUwgdiVe5a4w9/d4IuQfbqMX1SZ+lU2/MFLQP7L80VpVdKZbL3TFcGFYw==
X-Received: by 2002:a7b:c456:: with SMTP id l22mr3054466wmi.73.1611051425483; 
 Tue, 19 Jan 2021 02:17:05 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id w18sm34729229wrn.2.2021.01.19.02.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jan 2021 02:17:04 -0800 (PST)
Date: Tue, 19 Jan 2021 11:16:46 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v9 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from
 IOMMU_DEV_FEAT_SVA
Message-ID: <YAaxjmJW+ZMvrhac@myrica>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-4-jean-philippe@linaro.org>
 <4de8ef03-a2ed-316e-d3e3-6b8474e20113@linux.intel.com>
 <X/1o72DTmzdCMhDz@myrica>
 <c88e5d74-098d-7f1d-a7bb-a89e40fb8fa4@linux.intel.com>
 <MWHPR11MB18868F53E5A9E0CF9975042B8CA90@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YAB0SHyUZbxprkL3@larix.localdomain>
 <636814a9-7dea-06f6-03ec-6a98dd30b7e3@linux.intel.com>
 <MWHPR11MB188653AF6EFA0E55DE17815F8CA40@MWHPR11MB1886.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR11MB188653AF6EFA0E55DE17815F8CA40@MWHPR11MB1886.namprd11.prod.outlook.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
 "guohanjun@huawei.com" <guohanjun@huawei.com>,
 "will@kernel.org" <will@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "lenb@kernel.org" <lenb@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 David Woodhouse <dwmw2@infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-accelerators@lists.ozlabs.org" <linux-accelerators@lists.ozlabs.org>
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

On Mon, Jan 18, 2021 at 06:54:28AM +0000, Tian, Kevin wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Saturday, January 16, 2021 11:54 AM
> > 
> > Hi Jean,
> > 
> > On 2021/1/15 0:41, Jean-Philippe Brucker wrote:
> > > I guess detailing what's needed for nested IOPF can help the discussion,
> > > although I haven't seen any concrete plan about implementing it, and it
> > > still seems a couple of years away. There are two important steps with
> > > nested IOPF:
> > >
> > > (1) Figuring out whether a fault comes from L1 or L2. A SMMU stall event
> > >      comes with this information, but a PRI page request doesn't. The
> > IOMMU
> > >      driver has to first translate the IOVA to a GPA, injecting the fault
> > >      into the guest if this translation fails by using the usual
> > >      iommu_report_device_fault().
> 
> The IOMMU driver can walk the page tables to find out the level information.
> If the walk terminates at the 1st level, inject to the guest. Otherwise fix the 
> mm fault at 2nd level. It's not efficient compared to hardware-provided info,
> but it's doable and actual overhead needs to be measured (optimization exists
> e.g. having fault client to hint no 2nd level fault expected when registering fault
> handler in pinned case).
> 
> > >
> > > (2) Translating the faulting GPA to a HVA that can be fed to
> > >      handle_mm_fault(). That requires help from KVM, so another interface -
> > >      either KVM registering GPA->HVA translation tables or IOMMU driver
> > >      querying each translation. Either way it should be reusable by device
> > >      drivers that implement IOPF themselves.
> 
> Or just leave to the fault client (say VFIO here) to figure it out. VFIO has the
> information about GPA->HPA and can then call handle_mm_fault to fix the
> received fault. The IOMMU driver just exports an interface for the device drivers 
> which implement IOPF themselves to report a fault which is then handled by
> the IOMMU core by reusing the same faulting path.
> 
> > >
> > > (1) could be enabled with iommu_dev_enable_feature(). (2) requires a
> > more
> > > complex interface. (2) alone might also be desirable - demand-paging for
> > > level 2 only, no SVA for level 1.
> 
> Yes, this is what we want to point out. A general FEAT_IOPF implies more than
> what this patch intended to address.
> 
> > >
> > > Anyway, back to this patch. What I'm trying to convey is "can the IOMMU
> > > receive incoming I/O page faults for this device and, when SVA is enabled,
> > > feed them to the mm subsystem?  Enable that or return an error." I'm stuck
> > > on the name. IOPF alone is too vague. Not IOPF_L1 as Kevin noted, since L1
> > > is also used in virtualization. IOPF_BIND and IOPF_SVA could also mean (2)
> > > above. IOMMU_DEV_FEAT_IOPF_FLAT?
> > >
> > > That leaves space for the nested extensions. (1) above could be
> > > IOMMU_FEAT_IOPF_NESTED, and (2) requires some new interfacing with
> > KVM (or
> > > just an external fault handler) and could be used with either IOPF_FLAT or
> > > IOPF_NESTED. We can figure out the details later. What do you think?
> > 
> > I agree that we can define IOPF_ for current usage and leave space for
> > future extensions.
> > 
> > IOPF_FLAT represents IOPF on first-level translation, currently first
> > level translation could be used in below cases.
> > 
> > 1) FL w/ internal Page Table: Kernel IOVA;
> > 2) FL w/ external Page Table: VFIO passthrough;
> > 3) FL w/ shared CPU page table: SVA
> > 
> > We don't need to support IOPF for case 1). Let's put it aside.
> > 
> > IOPF handling of 2) and 3) are different. Do we need to define different
> > names to distinguish these two cases?
> > 
> 
> Defining feature names according to various use cases does not sound a
> clean way. In an ideal way we should have just a general FEAT_IOPF since
> the hardware (at least VT-d) does support fault in either 1st-level, 2nd-
> level or nested configurations. We are entering this trouble just because
> there is difficulty for the software evolving to enable full hardware cap
> in one batch. My last proposal was sort of keeping FEAT_IOPF as a general
> capability for whether delivering fault through the IOMMU or the ad-hoc
> device, and then having a separate interface for whether IOPF reporting
> is available under a specific configuration. The former is about the path
> between the IOMMU and the device, while the latter is about the interface
> between the IOMMU driver and its faulting client.
> 
> The reporting capability can be checked when the fault client is registering 
> its fault handler, and at this time the IOMMU driver knows how the related 
> mapping is configured (1st, 2nd, or nested) and whether fault reporting is 
> supported in such configuration. We may introduce IOPF_REPORT_FLAT and 
> IOPF_REPORT_NESTED respectively. while IOPF_REPORT_FLAT detection is 
> straightforward (2 and 3 can be differentiated internally based on configured 
> level), IOPF_REPORT_NESTED needs additional info to indicate which level is 
> concerned since the vendor driver may not support fault reporting in both 
> levels or the fault client may be interested in only one level (e.g. with 2nd
> level pinned).

I agree with this plan (provided I understood it correctly this time):
have IOMMU_DEV_FEAT_IOPF describing the IOPF interface between device and
IOMMU. Enabling it on its own doesn't do anything visible to the driver,
it just probes for capabilities and enables PRI if necessary. For host
SVA, since there is no additional communication between IOMMU and device
driver, enabling IOMMU_DEV_FEAT_SVA in addition to IOPF is sufficient.
Then when implementing nested we'll extend iommu_register_fault_handler()
with flags and parameters. That will also enable advanced dispatching (1).

Will it be necessary to enable FEAT_IOPF when doing VFIO passthrough
(injecting to the guest or handling it with external page tables)?
I think that would be better. Currently a device driver registering a
fault handler doesn't know if it will get recoverable page faults or only
unrecoverable ones.

So I don't think this patch needs any change. Baolu, are you ok with
keeping this and patch 4?

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
