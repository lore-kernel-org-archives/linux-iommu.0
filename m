Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78648C433E0
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 02:55:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B322080D
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 02:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgdnuPWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B322080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9F32487B4B;
	Fri, 19 Jun 2020 02:55:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wpwqayqL7DJK; Fri, 19 Jun 2020 02:55:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DD39F87B22;
	Fri, 19 Jun 2020 02:55:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C796AC07FF;
	Fri, 19 Jun 2020 02:55:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BA3FC016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 02:55:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8281B88CA3
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 02:55:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BIaBB5XAYcfU for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 02:55:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5280388CA2
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 02:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592535308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7fZXW43pbGVZ7R+1KVGi5S0xcHPVz1hHrkW0AlLVCro=;
 b=HgdnuPWxalyf5Fwhi89PGlrhHy4pBUlydSfnXsjMz9ipoDP5X8McagcMw1BPxi02Z6BDO8
 Xaqb3OqofG6UoHftQDOAY6EGmvfOvZOL0Dnyeu2t50lY54AYRLZy6INLdEgaFK+/fRO5Yd
 vdm/mTnaOXL8Kg/ps8AVVqPXHPKVTiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-8KoQrSfAO9i2Kqp2u1giTw-1; Thu, 18 Jun 2020 22:55:04 -0400
X-MC-Unique: 8KoQrSfAO9i2Kqp2u1giTw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C9A7107ACCA;
 Fri, 19 Jun 2020 02:55:02 +0000 (UTC)
Received: from x1.home (ovpn-112-195.phx2.redhat.com [10.3.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D60E5EDE2;
 Fri, 19 Jun 2020 02:54:58 +0000 (UTC)
Date: Thu, 18 Jun 2020 20:54:57 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 1/3] docs: IOMMU user API
Message-ID: <20200618205457.6969f9a7@x1.home>
In-Reply-To: <DM5PR11MB1435FA1C517087E8C5DEACB3C3980@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1591848735-12447-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1591848735-12447-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200611094741.6d118fa8@w520.home>
 <20200611125205.1e0280d3@jacob-builder>
 <20200611144047.79613c32@x1.home>
 <20200611172727.78dbb822@jacob-builder>
 <20200616082212.0c1611dd@jacob-builder>
 <DM5PR11MB1435DD578488DA08A1E699ACC39A0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <MWHPR11MB164595B754BE441255902DCA8C9A0@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20200618154805.049219db@w520.home>
 <DM5PR11MB1435FA1C517087E8C5DEACB3C3980@DM5PR11MB1435.namprd11.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
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

On Fri, 19 Jun 2020 02:15:36 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> Hi Alex,
> 
> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Friday, June 19, 2020 5:48 AM
> > 
> > On Wed, 17 Jun 2020 08:28:24 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >   
> > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > Sent: Wednesday, June 17, 2020 2:20 PM
> > > >  
> > > > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > > Sent: Tuesday, June 16, 2020 11:22 PM
> > > > >
> > > > > On Thu, 11 Jun 2020 17:27:27 -0700
> > > > > Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> > > > >  
> > > > > > >
> > > > > > > But then I thought it even better if VFIO leaves the entire
> > > > > > > copy_from_user() to the layer consuming it.
> > > > > > >  
> > > > > > OK. Sounds good, that was what Kevin suggested also. I just wasn't
> > > > > > sure how much VFIO wants to inspect, I thought VFIO layer wanted to do
> > > > > > a sanity check.
> > > > > >
> > > > > > Anyway, I will move copy_from_user to iommu uapi layer.  
> > > > >
> > > > > Just one more point brought up by Yi when we discuss this offline.
> > > > >
> > > > > If we move copy_from_user to iommu uapi layer, then there will be  
> > > > multiple  
> > > > > copy_from_user calls for the same data when a VFIO container has  
> > > > multiple domains,  
> > > > > devices. For bind, it might be OK. But might be additional overhead for TLB  
> > > > flush  
> > > > > request from the guest.  
> > > >
> > > > I think it is the same with bind and TLB flush path. will be multiple
> > > > copy_from_user.  
> > >
> > > multiple copies is possibly fine. In reality we allow only one group per
> > > nesting container (as described in patch [03/15]), and usually there
> > > is just one SVA-capable device per group.
> > >  
> > > >
> > > > BTW. for moving data copy to iommy layer, there is another point which
> > > > need to consider. VFIO needs to do unbind in bind path if bind failed,
> > > > so it will assemble unbind_data and pass to iommu layer. If iommu layer
> > > > do the copy_from_user, I think it will be failed. any idea?  
> > 
> > If a call into a UAPI fails, there should be nothing to undo.  Creating
> > a partial setup for a failed call that needs to be undone by the caller
> > is not good practice.  
> 
> is it still a problem if it's the VFIO to undo the partial setup before
> returning to user space?

Yes.  If a UAPI function fails there should be no residual effect.
 
> > > This might be mitigated if we go back to use the same bind_data for both
> > > bind/unbind. Then you can reuse the user object for unwinding.
> > >
> > > However there is another case where VFIO may need to assemble the
> > > bind_data itself. When a VM is killed, VFIO needs to walk allocated PASIDs
> > > and unbind them one-by-one. In such case copy_from_user doesn't work
> > > since the data is created by kernel. Alex, do you have a suggestion how this
> > > usage can be supported? e.g. asking IOMMU driver to provide two sets of
> > > APIs to handle user/kernel generated requests?  
> > 
> > Yes, it seems like vfio would need to make use of a driver API to do
> > this, we shouldn't be faking a user buffer in the kernel in order to
> > call through to a UAPI.  Thanks,  
> 
> ok, so if VFIO wants to issue unbind by itself, it should use an API which
> passes kernel buffer to IOMMU layer. If the unbind request is from user
> space, then VFIO should use another API which passes user buffer pointer
> to IOMMU layer. makes sense. will align with jacob.

Sounds right to me.  Different approaches might be used for the driver
API versus the UAPI, perhaps there is no buffer.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
