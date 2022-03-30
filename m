Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A0FC433EF
	for <iommu@archiver.kernel.org>; Wed, 30 Mar 2022 15:04:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE0AF6109B;
	Wed, 30 Mar 2022 15:04:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jvvd6WKdZzRV; Wed, 30 Mar 2022 15:04:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A3EB0608D8;
	Wed, 30 Mar 2022 15:04:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 777E4C002C;
	Wed, 30 Mar 2022 15:04:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A76FEC0012
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 15:04:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9477941C45
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 15:04:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X62iNCJ6IFSf for <iommu@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 15:04:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 87FE141C42
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 15:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648652678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tw2K5gl/MCSB4/A/fbU1d6ws7c+ie+K5t32hD35xsYk=;
 b=c6vpyXFSk5rqkJai2V17tt56byBC3Fzs8nWgZjP/ke5HZpC0TbTMb3XBc+uSqJ7PK0BxlP
 WA38ziMdl4gh7CqPmzzDyHKXreR4Y7NPfjd5okNv2uYYB4vUVEeaWFte/9a+otrW7+di/q
 6zKdqDnBwm+FGzAZPBWewWWJdfJj7uU=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-h1DEZbjQNgmH-ZMHH7N8mg-1; Wed, 30 Mar 2022 11:04:36 -0400
X-MC-Unique: h1DEZbjQNgmH-ZMHH7N8mg-1
Received: by mail-il1-f198.google.com with SMTP id
 k5-20020a056e02134500b002c9af0334e2so5294929ilr.11
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 08:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Tw2K5gl/MCSB4/A/fbU1d6ws7c+ie+K5t32hD35xsYk=;
 b=c8ELABbgrfII/3O5qOPk+GWr3quHy4R3mg4VPET5V3DCETEPtdY8cbJtvz2Ow9rk6t
 rXyBw3BsUaxAEEhFoD8CQkEdeilIX1k4WSPraAk7GXEkRs8y6UU7MiWFYNx0jrMEx19b
 M9KFZMrvW0w94FI0oT/umrBjQb09K/+gx7lob1sKl12LDnbiNmnnPACky47KwajFWMn1
 pkO4Om1vNi1OyX9oTMcRzB/HfqFeFS6mD0pVlcWJBAfC7tjTLDr81dvZIumD55SujRqp
 bzuLUsoCy9iSHMb9XWn083Tj9j+npg3423dta8ej2FdElEEBskrgPyEGvifXxy+ew6UW
 gdyg==
X-Gm-Message-State: AOAM5322B6ptrY1qO0UaDZxYq/sUnpAE3aJs7ZGPIxXo4p74iG5Ao4Cz
 TJEE8jXlKnZaR63A3u9Q9UqWQnpd63zLZOSeSfUfGZfQ/daLPGzgyKqM5wWJdFx3ih2Xta/mFB/
 t4/Ywyjd90OpZU4bGGDUeI+IRl2JTMQ==
X-Received: by 2002:a05:6638:191d:b0:321:3acb:ac8a with SMTP id
 p29-20020a056638191d00b003213acbac8amr28069jal.212.1648652676283; 
 Wed, 30 Mar 2022 08:04:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfihFwMtBBStLXYs+CPqbLhTdE7s40ejm+m3PFDIPROzfPRQ4jcPPTcNt2jC4McnNSgGoDWg==
X-Received: by 2002:a05:6638:191d:b0:321:3acb:ac8a with SMTP id
 p29-20020a056638191d00b003213acbac8amr28045jal.212.1648652675990; 
 Wed, 30 Mar 2022 08:04:35 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 h24-20020a6bfb18000000b006497692016bsm11938613iog.15.2022.03.30.08.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Mar 2022 08:04:35 -0700 (PDT)
Date: Wed, 30 Mar 2022 09:04:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Message-ID: <20220330090434.22224951.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB52766A3E3BC82EEF437258198C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220329114259.GB1716663@nvidia.com>
 <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330115820.GE1716663@nvidia.com>
 <BN9PR11MB52766A3E3BC82EEF437258198C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On Wed, 30 Mar 2022 14:18:47 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> +Alex
> 
> > From: Tian, Kevin
> > Sent: Wednesday, March 30, 2022 10:13 PM
> >   
> > > From: Jason Gunthorpe
> > > Sent: Wednesday, March 30, 2022 7:58 PM
> > >
> > > On Wed, Mar 30, 2022 at 06:50:11AM +0000, Tian, Kevin wrote:
> > >  
> > > > One thing that I'm not very sure is about DMA alias. Even when physically
> > > > there is only a single device within the group the aliasing could lead
> > > > to multiple RIDs in the group making it non-singleton. But probably we
> > > > don't need support SVA on such device until a real demand comes?  
> > >
> > > How can we have multiple RIDs in the same group and have only one
> > > device in the group?  
> > 
> > Alex may help throw some insight here. Per what I read from the code
> > looks like certain device can generate traffic with multiple RIDs.

You only need to look so far as the dma alias quirks to find devices
that use the wrong RID for DMA.  In general I don't think we have
enough confidence to say that for all these devices the wrong RID is
exclusively used versus some combination of both RIDs.  Also, the
aliased RID is not always a physical device.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
