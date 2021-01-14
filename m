Return-Path: <SRS0=IUlV=GR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61880C433E0
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 16:41:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5C923B1C
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 16:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5C923B1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C588A86BC0;
	Thu, 14 Jan 2021 16:41:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z+yvxHHThKD1; Thu, 14 Jan 2021 16:41:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 51B7086AE8;
	Thu, 14 Jan 2021 16:41:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36BFCC0893;
	Thu, 14 Jan 2021 16:41:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F225C013A
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 16:41:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 04462873CE
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 16:41:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BWtGmK9PwLXf for <iommu@lists.linux-foundation.org>;
 Thu, 14 Jan 2021 16:41:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AFD638730B
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 16:41:02 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id n26so9110923eju.6
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 08:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=PpcdUm/gcB3TMCtroKeX+86rJVww+0E1mxO6peOGnow=;
 b=FGHOZ9P0lE3tooUNruq7iIqeJ+RHltmSjWchoV2pjQXQDi8y359Fcjnd5WKAEXoTpK
 Y9OB1zMWocLiVTmE+InQdaXpQNjPDgUECLlWCOnGieGoM0J4RE/Wy7qXBK0sRi1DhEOs
 XVKh7vqG8/VFncTq/LU/PCwHf8zvYQDZF+x8FQplUHzBvgaonBa+BMGlMxcECbHfK8E3
 afZ/Nm8ZjPNH9Dti91WxyG1PxU1lPESE/XK7L1I+8CvnPM5MGPof6NUxHPf1rFmGa32u
 Ruke0VtajnvzD6VnyxNJgDPYRlLZHGk9L0cXHe6V3I1wPePxdBBMixEIBrLujoLqYjlM
 LIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PpcdUm/gcB3TMCtroKeX+86rJVww+0E1mxO6peOGnow=;
 b=aI1c0jTsbc1Pgam1CL+x8VXXYRPVpIOkkwl/N/89nU9eLzwl51jLlNbBJJlap+zUqz
 +yWH6Cwvmq+KrGHebobhTz7amOicQ5hXlP2QO2C4EQwQshYKBOE+JqqzpoPVrLkFsbpq
 ezie6BF/qJPJYruWeRtcYS8HWtXFZghuKASLOmj6B/4jZiav9v0vJquTiB1AD4rbqFd3
 1ErQ4IoPJJQRyuDHb30aH8cQ6FTad3ZgPTR8sLplKVpDT3+OTKW4+YCy01mawfHvVcTI
 xx5InfInxbGlvcX5PITjXZpWfJsVqJ55lmw+IfEIPMY00y3c0qlxPPiuH6srWO2fw3Vz
 oZBQ==
X-Gm-Message-State: AOAM533W3SwonN9ZKUdArleZHQWsaIi1Q9WLFjI1bx+b1mmmT4rYf32e
 DNLkYz/To5zM9C2OrzKAx0Rgxg==
X-Google-Smtp-Source: ABdhPJwiiUWF0wbqzhersCabuU1z96vEkPFvGfcvm3oB0CBDThtD+9g0uc7hvEvcDAoRh0d/m3WtnQ==
X-Received: by 2002:a17:906:b08f:: with SMTP id
 x15mr6030193ejy.36.1610642461135; 
 Thu, 14 Jan 2021 08:41:01 -0800 (PST)
Received: from larix.localdomain (adsl-84-226-106-126.adslplus.ch.
 [84.226.106.126])
 by smtp.gmail.com with ESMTPSA id cw7sm2123574ejc.13.2021.01.14.08.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jan 2021 08:41:00 -0800 (PST)
Date: Thu, 14 Jan 2021 17:41:44 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v9 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from
 IOMMU_DEV_FEAT_SVA
Message-ID: <YAB0SHyUZbxprkL3@larix.localdomain>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-4-jean-philippe@linaro.org>
 <4de8ef03-a2ed-316e-d3e3-6b8474e20113@linux.intel.com>
 <X/1o72DTmzdCMhDz@myrica>
 <c88e5d74-098d-7f1d-a7bb-a89e40fb8fa4@linux.intel.com>
 <MWHPR11MB18868F53E5A9E0CF9975042B8CA90@MWHPR11MB1886.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR11MB18868F53E5A9E0CF9975042B8CA90@MWHPR11MB1886.namprd11.prod.outlook.com>
X-TUID: nq/+KJqkCM9u
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

On Wed, Jan 13, 2021 at 08:10:28AM +0000, Tian, Kevin wrote:
> > >> Is this only for SVA? We may see more scenarios of using IOPF. For
> > >> example, when passing through devices to user level, the user's pages
> > >> could be managed dynamically instead of being allocated and pinned
> > >> statically.
> > >
> > > Hm, isn't that precisely what SVA does?  I don't understand the
> > > difference. That said FEAT_IOPF doesn't have to be only for SVA. It could
> > > later be used as a prerequisite some another feature. For special cases
> > > device drivers can always use the iommu_register_device_fault_handler()
> > > API and handle faults themselves.
> > 
> >  From the perspective of IOMMU, there is a little difference between
> > these two. For SVA, the page table is from CPU side, so IOMMU only needs
> > to call handle_mm_fault(); For above pass-through case, the page table
> > is from IOMMU side, so the device driver (probably VFIO) needs to
> > register a fault handler and call iommu_map/unmap() to serve the page
> > faults.
> > 
> > If we think about the nested mode (or dual-stage translation), it's more
> > complicated since the kernel (probably VFIO) handles the second level
> > page faults, while the first level page faults need to be delivered to
> > user-level guest. Obviously, this hasn't been fully implemented in any
> > IOMMU driver.
> > 
> 
> Thinking more the confusion might come from the fact that we mixed
> hardware capability with software capability. IOMMU_FEAT describes
> the hardware capability. When FEAT_IOPF is set, it purely means whatever
> page faults that are enabled by the software are routed through the IOMMU.
> Nothing more. Then the software (IOMMU drivers) may choose to support
> only limited faulting scenarios and then evolve to support more complex 
> usages gradually. For example, the intel-iommu driver only supports 1st-level
> fault (thus SVA) for now, while FEAT_IOPF as a separate feature may give the
> impression that 2nd-level faults are also allowed. From this angle once we 
> start to separate page fault from SVA, we may also need a way to report 
> the software capability (e.g. a set of faulting categories) and also extend
> iommu_register_device_fault_handler to allow specifying which 
> category is enabled respectively. The example categories could be:
> 
> - IOPF_BIND, for page tables which are bound/linked to the IOMMU. 
> Apply to bare metal SVA and guest SVA case;

These don't seem to fit in the same software capability, since the action
to perform on incoming page faults is very different. In the first case
the fault handling is entirely contained within the IOMMU driver; in the
second case the IOMMU driver only tracks page requests, and offloads
handling to VFIO.

> - IOPF_MAP, for page tables which are managed through explicit IOMMU
> map interfaces. Apply to removing VFIO pinning restriction;

From the IOMMU perspective this is the same as guest SVA, no? VFIO
registering a fault handler and doing the bulk of the work itself.

> Both categories can be enabled together in nested translation, with 
> additional information provided to differentiate them in fault information.
> Using paging/staging level doesn't make much sense as it's IOMMU driver's 
> internal knowledge, e.g. VT-d driver plans to use 1st level for GPA if no 
> nesting and then turn to 2nd level when nesting is enabled.

I guess detailing what's needed for nested IOPF can help the discussion,
although I haven't seen any concrete plan about implementing it, and it
still seems a couple of years away. There are two important steps with
nested IOPF:

(1) Figuring out whether a fault comes from L1 or L2. A SMMU stall event
    comes with this information, but a PRI page request doesn't. The IOMMU
    driver has to first translate the IOVA to a GPA, injecting the fault
    into the guest if this translation fails by using the usual
    iommu_report_device_fault().

(2) Translating the faulting GPA to a HVA that can be fed to
    handle_mm_fault(). That requires help from KVM, so another interface -
    either KVM registering GPA->HVA translation tables or IOMMU driver
    querying each translation. Either way it should be reusable by device
    drivers that implement IOPF themselves.

(1) could be enabled with iommu_dev_enable_feature(). (2) requires a more
complex interface. (2) alone might also be desirable - demand-paging for
level 2 only, no SVA for level 1.

Anyway, back to this patch. What I'm trying to convey is "can the IOMMU
receive incoming I/O page faults for this device and, when SVA is enabled,
feed them to the mm subsystem?  Enable that or return an error." I'm stuck
on the name. IOPF alone is too vague. Not IOPF_L1 as Kevin noted, since L1
is also used in virtualization. IOPF_BIND and IOPF_SVA could also mean (2)
above. IOMMU_DEV_FEAT_IOPF_FLAT?

That leaves space for the nested extensions. (1) above could be
IOMMU_FEAT_IOPF_NESTED, and (2) requires some new interfacing with KVM (or
just an external fault handler) and could be used with either IOPF_FLAT or
IOPF_NESTED. We can figure out the details later. What do you think?

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
