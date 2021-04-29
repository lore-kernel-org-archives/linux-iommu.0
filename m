Return-Path: <SRS0=7BBB=J2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B39CC433ED
	for <iommu@archiver.kernel.org>; Thu, 29 Apr 2021 08:54:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B75E61444
	for <iommu@archiver.kernel.org>; Thu, 29 Apr 2021 08:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B75E61444
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2514A41940;
	Thu, 29 Apr 2021 08:54:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6jKeasEQ0P3S; Thu, 29 Apr 2021 08:54:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7581141926;
	Thu, 29 Apr 2021 08:54:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D432C000D;
	Thu, 29 Apr 2021 08:54:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22DFCC0001
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 08:54:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EF5FA41940
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 08:54:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ykf30mOsos2W for <iommu@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 08:54:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7F8E341926
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 08:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619686483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MJmZaciikGlYP7vXYgk4XTNBBfK7yKCOZZwkCAQl4Oc=;
 b=a/roMCXg2zneUkm754wwYZ5ss6192D9MljXstgOduzEIr7g7Vc+mbajDfVP4xGCECV3q52
 QzCU+npNWkBjWyGWWxQvXDl1ixmf/qhDb71Z3oGgFe1QJeZFRfurfSRFbSw2fxXjPg+SdW
 PUiPuXUOpc1Ulf3tG5g0AE2bxmsreq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-XMzTNDZLPY-xdejBATNeRQ-1; Thu, 29 Apr 2021 04:54:40 -0400
X-MC-Unique: XMzTNDZLPY-xdejBATNeRQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D6DA501E3;
 Thu, 29 Apr 2021 08:54:38 +0000 (UTC)
Received: from [10.36.113.191] (ovpn-113-191.ams2.redhat.com [10.36.113.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71B161002D71;
 Thu, 29 Apr 2021 08:54:29 +0000 (UTC)
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
References: <20210416094547.1774e1a3@redhat.com>
 <BN6PR11MB406854F56D18E1187A2C98ACC3479@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210421162307.GM1370958@nvidia.com> <20210421105451.56d3670a@redhat.com>
 <20210421175203.GN1370958@nvidia.com> <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210422121020.GT1370958@nvidia.com>
 <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210423114944.GF1370958@nvidia.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <0d1d0240-865e-c4f0-7b3b-41ac8ae2e550@redhat.com>
Date: Thu, 29 Apr 2021 10:54:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210423114944.GF1370958@nvidia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Li Zefan <lizefan@huawei.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu,
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

Hi,

On 4/23/21 1:49 PM, Jason Gunthorpe wrote:
> On Fri, Apr 23, 2021 at 09:06:44AM +0000, Tian, Kevin wrote:
> 
>> Or could we still have just one /dev/ioasid but allow userspace to create
>> multiple gpa_ioasid_id's each associated to a different iommu domain? 
>> Then the compatibility check will be done at ATTACH_IOASID instead of 
>> JOIN_IOASID_FD.
> 
> To my mind what makes sense that that /dev/ioasid presents a single
> IOMMU behavior that is basically the same. This may ultimately not be
> what we call a domain today.
> 
> We may end up with a middle object which is a group of domains that
> all have the same capabilities, and we define capabilities in a way
> that most platforms have a single group of domains.
> 
> The key capability of a group of domains is they can all share the HW
> page table representation, so if an IOASID instantiates a page table
> it can be assigned to any device on any domain in the gruop of domains.
> 
> If you try to say that /dev/ioasid has many domains and they can't
> have their HW page tables shared then I think the implementation
> complexity will explode.
> 
>> This does impose one burden to userspace though, to understand the 
>> IOMMU compatibilities and figure out which incompatible features may
>> affect the page table management (while such knowledge is IOMMU
>> vendor specific) and then explicitly manage multiple /dev/ioasid's or 
>> multiple gpa_ioasid_id's.
> 
> Right, this seems very hard in the general case..
>  
>> Alternatively is it a good design by having the kernel return error at
>> attach/join time to indicate that incompatibility is detected then the 
>> userspace should open a new /dev/ioasid or creates a new gpa_ioasid_id
>> for the failing device upon such failure, w/o constructing its own 
>> compatibility knowledge?
> 
> Yes, this feels workable too
> 
>>> This means qemue might have multiple /dev/ioasid's if the system has
>>> multiple incompatible IOMMUs (is this actually a thing?) The platform
>>
>> One example is Intel platform with igd. Typically there is one IOMMU
>> dedicated for igd and the other IOMMU serving all the remaining devices.
>> The igd IOMMU may not support IOMMU_CACHE while the other one
>> does.
> 
> If we can do as above the two domains may be in the same group of
> domains and the IOMMU_CACHE is not exposed at the /dev/ioasid level.
> 
> For instance the API could specifiy IOMMU_CACHE during attach, not
> during IOASID creation.
> 
> Getting all the data model right in the API is going to be trickiest
> part of this.
> 
>> yes, e.g. in vSVA both devices (behind divergence IOMMUs) are bound
>> to a single guest process which has an unique PASID and 1st-level page
>> table. Earlier incompatibility example is only for 2nd-level.
> 
> Because when we get to here, things become inscrutable as an API if
> you are trying to say two different IOMMU presentations can actually
> be nested.
> 
>>> Sure.. The tricky bit will be to define both of the common nested
>>> operating modes.
>>>
>>>   nested_ioasid = ioctl(ioasid_fd, CREATE_NESTED_IOASID,  gpa_ioasid_id);
>>>   ioctl(ioasid_fd, SET_NESTED_IOASID_PAGE_TABLES, nested_ioasid, ..)
>>>
>>>    // IOMMU will match on the device RID, no PASID:
>>>   ioctl(vfio_device, ATTACH_IOASID, nested_ioasid);
>>>
>>>    // IOMMU will match on the device RID and PASID:
>>>   ioctl(vfio_device, ATTACH_IOASID_PASID, pasid, nested_ioasid);
>>
>> I'm a bit confused here why we have both pasid and ioasid notations together.
>> Why not use nested_ioasid as pasid directly (i.e. every pasid in nested mode
>> is created by CREATE_NESTED_IOASID)?
> 
> The IOASID is not a PASID, it is just a page table.
> 
> A generic IOMMU matches on either RID or (RID,PASID), so you should
> specify the PASID when establishing the match.
> 
> IOASID only specifies the page table.
> 
> So you read the above as configuring the path
> 
>   PCI_DEVICE -> (RID,PASID) -> nested_ioasid -> gpa_ioasid_id -> physical
> 
> Where (RID,PASID) indicate values taken from the PCI packet.
> 
> In principle the IOMMU could also be commanded to reuse the same
> ioasid page table with a different PASID:
> 
>   PCI_DEVICE_B -> (RID_B,PASID_B) -> nested_ioasid -> gpa_ioasid_id -> physical
> 
> This is impossible if the ioasid == PASID in the API.
> 
>> Below I list different scenarios for ATTACH_IOASID in my view. Here 
>> vfio_device could be a real PCI function (RID), or a subfunction device 
>> (RID+def_ioasid). 
> 
> What is RID+def_ioasid? The IOMMU does not match on IOASID's.
> 
> A subfunction device always need to use PASID, or an internal IOMMU,
> confused what you are trying to explain?
> 
>> If the whole PASID table is delegated to the guest in ARM case, the guest
>> can select its own PASIDs w/o telling the hypervisor. 
> 
> The hypervisor has to route the PASID's to the guest at some point - a
> guest can't just claim a PASID unilaterally, that would not be secure.
AFAIU On ARM the stage 2 table is uniquely defined per RID and the PASID
space is local to the RID. in other words all PASIDs used along with a
given RID share the same stage 2 page table. So the minimum granularity
for guest assignment still is the RID and not the PASID (there is no
scalable mode on ARM). on x86, with scalable mode, each RID/PASID can
have different stage1/stage2 tables which make the minimum granularity
for guest device assignment the PASID.

So on ARM the guest can allocate PASIDs without interfering with the
host. We just need to make sure the PASID table format and max entries
matches the capability of the HW.

If the min granularity for guest assignment were the RID/PASID
effectively a guest could steal all the PASIDs for a given RID.

Thanks

Eric
> 
> If it is not done with per-PASID hypercalls then the hypervisor has to
> route all PASID's for a RID to the guest and /dev/ioasid needs to have
> a nested IOASID object that represents this connection - ie it points
> to the PASID table of the guest vIOMMU or something.
> 
> Remember this all has to be compatible with mdev's too and without
> hypercalls to create PASIDs that will be hard: mdev sharing a RID and
> slicing the physical PASIDs can't support a 'send all PASIDs to the
> guest' model, or even a 'the guest gets to pick the PASID' option.
> 
> Jason
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
