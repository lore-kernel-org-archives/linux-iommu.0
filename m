Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CC4C48BE6
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 03:23:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E94A96138C
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 03:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94A96138C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B13B483AAF;
	Mon, 14 Jun 2021 03:23:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JpFMRtm0Kvti; Mon, 14 Jun 2021 03:23:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 56EE483AAE;
	Mon, 14 Jun 2021 03:23:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DAEFC000E;
	Mon, 14 Jun 2021 03:23:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED156C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 03:23:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC3F16067F
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 03:23:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VsKMsn4XUxtb for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 03:23:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A90C56063F
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 03:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623640986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DH6kGuqwSpyXtcecevk99gjqJDJGvAzEG8igZ3sFLDE=;
 b=BVHP1NwBmb2+8dOT2YPRAER/SEkh+IoRGrXv1BcCcDCneH7SQJzLnBaKMz7yssyUeyv7w5
 zv8FhYWYhQobWzKQMVqCfGFia1tKFo8NUxGWnv7xmu7W0cHk2ZNS3/hJE0JhfQnMG9yfBr
 +WU2RwBRblADr1fVNvCUDAwsc+Wn5hM=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-Rks4tadzPGqMNljSpZN7Eg-1; Sun, 13 Jun 2021 23:23:02 -0400
X-MC-Unique: Rks4tadzPGqMNljSpZN7Eg-1
Received: by mail-oi1-f198.google.com with SMTP id
 l136-20020acaed8e0000b02901f3ebfedbf2so5071226oih.11
 for <iommu@lists.linux-foundation.org>; Sun, 13 Jun 2021 20:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=DH6kGuqwSpyXtcecevk99gjqJDJGvAzEG8igZ3sFLDE=;
 b=R81uZGZPefc9Hr76sYPEdL4Zf+4jkB+pdmIIHtebhPNyBr1z+MyaAjdEsBPUgsD2cT
 4Jn3pQGJBAk7ulI0+iE6zggC2nHOIeOG1Vl0B2jS2A7kWacXJnw2Ua7Osogbq3+/m7bS
 0VTPbUQMjKcPckEV8WN5EXAcxVajHz4Zb+Hu2w9VbzhQfMkiSaXAWwXzdyv9pEOt1BT6
 LJBQD9UVLYbg3pPbwxph76yB3aPS2H02KOKT1TNUVK3ghKR9OGppidF8gSTaZb9uupgl
 VGZYWVKxAzdaeNT3vVyjFD3qo39YVif1+paxk0PDwF4OoN9iRn+QRMM/1pJtOLAGEIAa
 syDQ==
X-Gm-Message-State: AOAM530t9SydJLz2f4T6c2sptC9kYRhM/z5mgm7P+JBY9q0pOEqlBy+z
 SHj0+M6DKbjxlb7ixU2el1Hi53/UMC87W5LNwqOPq8myRp+uYSTJkHocRf8fKNE1nKbE9M30wED
 RoH7Tjoyfw0nMeY1u8RSKekv+xT4/wg==
X-Received: by 2002:a4a:d781:: with SMTP id c1mr11469398oou.23.1623640981482; 
 Sun, 13 Jun 2021 20:23:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6xToi4wIBsXCCzc9rWc2XuIt2xUM51JIjsKt+2k+TNY3lc6glz0mU52oI39ABCxtmA6uP+Q==
X-Received: by 2002:a4a:d781:: with SMTP id c1mr11469382oou.23.1623640981204; 
 Sun, 13 Jun 2021 20:23:01 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id c205sm2706192oib.20.2021.06.13.20.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Jun 2021 20:23:00 -0700 (PDT)
Date: Sun, 13 Jun 2021 21:22:58 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: Plan for /dev/ioasid RFC v2
Message-ID: <20210613212258.6f2a2dac.alex.williamson@redhat.com>
In-Reply-To: <MWHPR11MB1886C2A0A8AA3000EBD5F8E18C319@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <MWHPR11MB188699D0B9C10EB51686C4138C389@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YMCy48Xnt/aphfh3@8bytes.org> <20210609123919.GA1002214@nvidia.com>
 <YMDC8tOMvw4FtSek@8bytes.org> <20210609150009.GE1002214@nvidia.com>
 <YMDjfmJKUDSrbZbo@8bytes.org>
 <20210609101532.452851eb.alex.williamson@redhat.com>
 <20210609102722.5abf62e1.alex.williamson@redhat.com>
 <20210609184940.GH1002214@nvidia.com>
 <20210610093842.6b9a4e5b.alex.williamson@redhat.com>
 <BN6PR11MB187579A2F88C77ED2131CEF08C349@BN6PR11MB1875.namprd11.prod.outlook.com>
 <20210611153850.7c402f0b.alex.williamson@redhat.com>
 <MWHPR11MB1886C2A0A8AA3000EBD5F8E18C319@MWHPR11MB1886.namprd11.prod.outlook.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>,
 "parav@mellanox.com" <parav@mellanox.com>, "Enrico Weigelt, metux IT
 consult" <lkml@metux.net>, David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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

On Mon, 14 Jun 2021 03:09:31 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Saturday, June 12, 2021 5:39 AM
> > 
> > On Fri, 11 Jun 2021 00:58:35 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >   
> > > Hi, Alex,
> > >  
> > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > Sent: Thursday, June 10, 2021 11:39 PM
> > > >
> > > > On Wed, 9 Jun 2021 15:49:40 -0300
> > > > Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > >  
> > > > > On Wed, Jun 09, 2021 at 10:27:22AM -0600, Alex Williamson wrote:
> > > > >  
> > > > > > > > It is a kernel decision, because a fundamental task of the kernel is  
> > to  
> > > > > > > > ensure isolation between user-space tasks as good as it can. And if  
> > a  
> > > > > > > > device assigned to one task can interfer with a device of another  
> > task  
> > > > > > > > (e.g. by sending P2P messages), then the promise of isolation is  
> > > > broken.  
> > > > > > >
> > > > > > > AIUI, the IOASID model will still enforce IOMMU groups, but it's not  
> > an  
> > > > > > > explicit part of the interface like it is for vfio.  For example the
> > > > > > > IOASID model allows attaching individual devices such that we have
> > > > > > > granularity to create per device IOASIDs, but all devices within an
> > > > > > > IOMMU group are required to be attached to an IOASID before they  
> > can  
> > > > be  
> > > > > > > used.  
> > > > >
> > > > > Yes, thanks Alex
> > > > >  
> > > > > > > It's not entirely clear to me yet how that last bit gets
> > > > > > > implemented though, ie. what barrier is in place to prevent device
> > > > > > > usage prior to reaching this viable state.  
> > > > >
> > > > > The major security checkpoint for the group is on the VFIO side.  We
> > > > > must require the group before userspace can be allowed access to any
> > > > > device registers. Obtaining the device_fd from the group_fd does this
> > > > > today as the group_fd is the security proof.
> > > > >
> > > > > Actually, thinking about this some more.. If the only way to get a
> > > > > working device_fd in the first place is to get it from the group_fd
> > > > > and thus pass a group-based security check, why do we need to do
> > > > > anything at the ioasid level?
> > > > >
> > > > > The security concept of isolation was satisfied as soon as userspace
> > > > > opened the group_fd. What do more checks in the kernel accomplish?  
> > > >
> > > > Opening the group is not the extent of the security check currently
> > > > required, the group must be added to a container and an IOMMU model
> > > > configured for the container *before* the user can get a devicefd.
> > > > Each devicefd creates a reference to this security context, therefore
> > > > access to a device does not exist without such a context.  
> > >
> > > IIUC each device has a default domain when it's probed by iommu driver
> > > at boot time. This domain includes an empty page table, implying that
> > > device is already in a security context before it's probed by device driver.  
> > 
> > The default domain could be passthrough though, right?  
> 
> Good point.
> 
> >   
> > > Now when this device is added to vfio, vfio creates another security
> > > context through above sequence. This sequence requires the device to
> > > switch from default security context to this new one, before it can be
> > > accessed by user.  
> > 
> > This is true currently, we use group semantics with the type1 IOMMU
> > backend to attach all devices in the group to a secure context,
> > regardless of the default domain.
> >   
> > > Then I wonder whether it's really necessary. As long as a device is in
> > > a security context at any time, access to a device can be allowed. The
> > > user itself should ensure that the access happens only after the device
> > > creates a reference to the new security context that is desired by this
> > > user.
> > >
> > > Then what does group really bring to us?  
> > 
> > By definition an IOMMU group is the smallest set of devices that we
> > can consider isolated from all other devices.  Therefore devices in a
> > group are not necessarily isolated from each other.  Therefore if any
> > device within a group is not isolated, the group is not isolated.  VFIO
> > needs to know when it's safe to provide userspace access to the device,
> > but the device isolation is dependent on the group isolation.  The
> > group is therefore part of this picture whether implicit or explicit.
> >   
> > > With this new proposal we just need to make sure that a device cannot
> > > be attached to any IOASID before all devices in its group are bound to
> > > the IOASIDfd. If we want to start with a vfio-like policy, then all devices
> > > in the group must be attached to the same IOASID. Or as Jason suggests,
> > > they can attach to different IOASIDs (if in the group due to !ACS) if the
> > > user wants, or have some devices attached while others detached since
> > > both are in a security context anyway.  
> > 
> > But if it's the device attachment to the IOASID that provides the
> > isolation and the user might attach a device to multiple IOASIDs within
> > the same IOASIDfd, and presumably make changes to the mapping of device
> > to IOASID dynamically, are we interrupting user access around each of
> > those changes?  How would vfio be able to track this, and not only
> > track it per device, but for all devices in the group.  Suggesting a
> > user needs to explicitly attach every device in the group is also a
> > semantic change versus existing vfio, where other devices in the group
> > must only be considered to be in a safe state for the group to be
> > usable.
> > 
> > The default domain may indeed be a solution to the problem, but we need
> > to enforce a secure default domain for all devices in the group.  To me
> > that suggests that binding the *group* to an IOASIDfd is the point at
> > which device access becomes secure.  VFIO should be able to consider
> > that the IOASIDfd binding has taken over ownership of the DMA context
> > for the device and it will always be either an empty, isolated, default
> > domain or a user defined IOASID.  
> 
> Yes, this is one way of enforcing the group security.
> 
> In the meantime, I'm thinking about another way whether group 
> security can be enforced in the iommu layer to relax the uAPI design. 
> If a device can be always blocked from accessing memory in the 
> IOMMU before it's bound to a driver or more specifically before
> the driver moves it to a new security context, then there is no need
> for VFIO to track whether IOASIDfd has taken over ownership of
> the DMA context for all devices within a group.

But we know we don't have IOMMU level isolation between devices in the
same group, so I don't see how this helps us.

> But as you said this cannot be achieved via existing default domain
> approach. So far a device is always attached to a domain:
> 
> - DOMAIN_IDENTITY: a default domain without DMA protection
> - DOMAIN_DMA: a default domain with DMA protection via DMA 
>   API and iommu core
> - DOMAIN_UNMANAGED: a driver-created domain which is not
>    managed by iommu core.
> 
> The special sequence in current vfio group design is to mitigate
> the 1st case, i.e. if a device is left in passthrough mode before
> bound to VFIO it's definitely insecure to allow user to access it.
> Then the sequence ensures that the user access is granted on it
> only after all devices within a group switch to a security context.
> 
> Now if the new proposed scheme can be supported, a device
> is always in a security context (block-dma) before it's switched 
> to a new security context and existing domain types should be 
> applied only in the new context when the device starts to do 
> DMAs. For VFIO case this switch happens explicitly when attaching 
> the device to an IOASID. For kernel driver it's implicit e.g. could
> happen when the 1st DMA API call is received. 
> 
> If this works I didn't see the need for vfio to keep the sequence. 
> VFIO still keeps group fd to claim ownership of all devices in a 
> group. Once it's done, vfio doesn't need to track the device attach 
> status and user access can be always granted regardless of 
> how the attach status changes. Moving a device from IOASID1 
> to IOASID2 involves detaching from IOASID1 (back to blocked
> dma context) and then reattaching to IOASID2 (switch to a
> new security context).
> 
> Following this direction even IOASIDfd doesn't need to verify
> the group attach upon such guarantee from the iommu layer. 
> The devices within a group can be in different security contexts,
> e.g. with some devices attached to GPA IOASID while others not 
> attached. In this way vfio userspace could choose to not attach 
> every device of a group to sustain the current semantics.

It seems like this entirely misses the point of groups with multiple
devices.  If we had IOMMU level isolation between all devices, we'd
never have multi-device groups.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
