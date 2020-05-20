Return-Path: <SRS0=jIn/=7C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F43C433DF
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 14:10:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D36AE207D4
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 14:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aU7XHviT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36AE207D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2377486DC2;
	Wed, 20 May 2020 14:09:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5CDDrpIaSHmO; Wed, 20 May 2020 14:09:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 38F6286D88;
	Wed, 20 May 2020 14:09:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18AF2C088A;
	Wed, 20 May 2020 14:09:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FA23C0176
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 14:09:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1864987E8A
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 14:09:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ty58gkypx6dK for <iommu@lists.linux-foundation.org>;
 Wed, 20 May 2020 14:09:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 02CA687AB5
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 14:09:13 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id w64so3007147wmg.4
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 07:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5XoJzIvuoDxk2icnoMh30USN5ZKY5vYk0ahPprSURXg=;
 b=aU7XHviTPsBM79cD5P0FtOsRdSVtABt6zbWMK2S9iHCt0ISlDZreVNFSoQyoU4s7t0
 l4GL6P+8NTVoWPLAXgdxE3v8U2O5AuCjsmjVnE5aX0w2sZ2snAIRPsCwXeKrhF/M203R
 vH1DNBocW69G1ASrMPesdHpl4CXQ3styHpUrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5XoJzIvuoDxk2icnoMh30USN5ZKY5vYk0ahPprSURXg=;
 b=GDT+JeAqfy/ZZvfhaPFrUwdutyENFpGdluDeklSmF/VZU02W1lAd+iHhokqJPDIY57
 hh1ZgU7EDHLJX7r4AQbVjlp/GSV7A+IgnP2IOc1E2urT2apKgdPldJFM5sTUj0AFUSuA
 IZ2IZb4EC74o7TEqZ+UtmSQeEgRJ1DomQxvtqsaecmc3q5toUosQ9n4zZLK1KCQDJ1Pt
 xUtwcDmNpZZzAM1IyFXpiG8sINRkefoMVCbnoXcCBjP57VF3li1zOaohseS1H2x8UdAW
 ad6oQYHYK3yQYGGS2VNO74l3ldh2P6Be0d5kcUmaJlccOc3ZJVjPA72d/Xhd+LFvFYFW
 XXCQ==
X-Gm-Message-State: AOAM533CuZojVcs1rPxvD+e0rfbwue+K6NP8TfMQgw8bhTwHMSVjk5+m
 xca2v75d1brBPRrNmAlBFNf2diEFb9gSm1KfAygeIA==
X-Google-Smtp-Source: ABdhPJy8+aaE75w2j6LM8UdDVTfpm5fsqus8lix4HOzCfW2Om0mQ70U9CqyysIskmtTUIPYqRl8eiRBclxcac+59LxY=
X-Received: by 2002:a1c:7305:: with SMTP id d5mr4967930wmb.85.1589983752391;
 Wed, 20 May 2020 07:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
 <20200519203419.12369-10-james.quinlan@broadcom.com>
 <20200520054349.GB2180554@kroah.com>
 <CA+-6iNyQFauYc0ZNbzRmao_oOZD8XM+1D0XE133HP_-zgMLzuA@mail.gmail.com>
 <20200520140320.GA3624154@kroah.com>
In-Reply-To: <20200520140320.GA3624154@kroah.com>
Date: Wed, 20 May 2020 10:08:59 -0400
Message-ID: <CA+-6iNx191UTktahqtb9uPEq2SqMf3mAH9WD-ffavoN6zwJSwA@mail.gmail.com>
Subject: Re: [PATCH 09/15] device core: Add ability to handle multiple dma
 offsets
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Saravana Kannan <saravanak@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Frank Rowand <frowand.list@gmail.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
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
From: Jim Quinlan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jim Quinlan <james.quinlan@broadcom.com>
Content-Type: multipart/mixed; boundary="===============7397478299287332320=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============7397478299287332320==
Content-Type: multipart/alternative; boundary="000000000000c2ec2405a614f0b7"

--000000000000c2ec2405a614f0b7
Content-Type: text/plain; charset="UTF-8"

On Wed, May 20, 2020 at 10:03 AM Greg Kroah-Hartman <
gregkh@linuxfoundation.org> wrote:

> On Wed, May 20, 2020 at 09:50:36AM -0400, Jim Quinlan wrote:
> > On Wed, May 20, 2020 at 1:43 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, May 19, 2020 at 04:34:07PM -0400, Jim Quinlan wrote:
> > > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > > index ac8e37cd716a..6cd916860b5f 100644
> > > > --- a/include/linux/device.h
> > > > +++ b/include/linux/device.h
> > > > @@ -493,6 +493,8 @@ struct dev_links_info {
> > > >   * @bus_dma_limit: Limit of an upstream bridge or bus which imposes
> a smaller
> > > >   *           DMA limit than the device itself supports.
> > > >   * @dma_pfn_offset: offset of DMA memory range relatively of RAM
> > > > + * @dma_map: Like dma_pfn_offset but used when there are multiple
> > > > + *           pfn offsets for multiple dma-ranges.
> > > >   * @dma_parms:       A low level driver may set these to teach
> IOMMU code about
> > > >   *           segment limitations.
> > > >   * @dma_pools:       Dma pools (if dma'ble device).
> > > > @@ -578,7 +580,12 @@ struct device {
> > > >                                            allocations such
> descriptors. */
> > > >       u64             bus_dma_limit;  /* upstream dma constraint */
> > > >       unsigned long   dma_pfn_offset;
> > > > -
> > > > +#ifdef CONFIG_DMA_PFN_OFFSET_MAP
> > > > +     const void *dma_offset_map;     /* Like dma_pfn_offset, but for
> > > > +                                      * the unlikely case of
> multiple
> > > > +                                      * offsets. If non-null,
> dma_pfn_offset
> > > > +                                      * will be 0. */
> > > > +#endif
> > > >       struct device_dma_parameters *dma_parms;
> > > >
> > > >       struct list_head        dma_pools;      /* dma pools (if
> dma'ble) */
> > >
> > > I'll defer to Christoph here, but I thought we were trying to get rid
> of
> > > stuff like this from struct device, not add new things to it for dma
> > Hi Greg,
> >
> > I wasn't aware of this policy.  I put it in 'struct device' because
> > just like the existing dma_pfn_offset; it seemed to be the only way to
> > pull this off.  I'll certainly follow any ideas on alternative
> > strategies from Christoph et al.
> >
> > > apis.  And why is it a void *?
> > Just wanted to minimize the number of lines I've added to device.h, no
> > other reason.
>
> How would using a real type make this more lines?  Never use a void *
> unless you have to, we want the compiler to check our errors for us :)
>

Got it; I did not need to define the struct in device.h.  Will fix if this
code makes it past v1 :-)

Jim



> thanks,
>
> greg k-h
>

--000000000000c2ec2405a614f0b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 20, 2020 at 10:03 AM Greg=
 Kroah-Hartman &lt;<a href=3D"mailto:gregkh@linuxfoundation.org">gregkh@lin=
uxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">On Wed, May 20, 2020 at 09:50:36AM -0400, Jim Quinlan wrote=
:<br>
&gt; On Wed, May 20, 2020 at 1:43 AM Greg Kroah-Hartman<br>
&gt; &lt;<a href=3D"mailto:gregkh@linuxfoundation.org" target=3D"_blank">gr=
egkh@linuxfoundation.org</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; On Tue, May 19, 2020 at 04:34:07PM -0400, Jim Quinlan wrote:<br>
&gt; &gt; &gt; diff --git a/include/linux/device.h b/include/linux/device.h=
<br>
&gt; &gt; &gt; index ac8e37cd716a..6cd916860b5f 100644<br>
&gt; &gt; &gt; --- a/include/linux/device.h<br>
&gt; &gt; &gt; +++ b/include/linux/device.h<br>
&gt; &gt; &gt; @@ -493,6 +493,8 @@ struct dev_links_info {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0* @bus_dma_limit: Limit of an upstream bridge or=
 bus which imposes a smaller<br>
&gt; &gt; &gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DMA li=
mit than the device itself supports.<br>
&gt; &gt; &gt;=C2=A0 =C2=A0* @dma_pfn_offset: offset of DMA memory range re=
latively of RAM<br>
&gt; &gt; &gt; + * @dma_map: Like dma_pfn_offset but used when there are mu=
ltiple<br>
&gt; &gt; &gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pfn offsets for =
multiple dma-ranges.<br>
&gt; &gt; &gt;=C2=A0 =C2=A0* @dma_parms:=C2=A0 =C2=A0 =C2=A0 =C2=A0A low le=
vel driver may set these to teach IOMMU code about<br>
&gt; &gt; &gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0segmen=
t limitations.<br>
&gt; &gt; &gt;=C2=A0 =C2=A0* @dma_pools:=C2=A0 =C2=A0 =C2=A0 =C2=A0Dma pool=
s (if dma&#39;ble device).<br>
&gt; &gt; &gt; @@ -578,7 +580,12 @@ struct device {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 allocations such descriptors. */<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bus_dma_limit;=C2=A0 /* upstream dma constraint */<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long=C2=A0 =C2=A0dma_pfn_=
offset;<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; +#ifdef CONFIG_DMA_PFN_OFFSET_MAP<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0const void *dma_offset_map;=C2=A0 =C2=
=A0 =C2=A0/* Like dma_pfn_offset, but for<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *=
 the unlikely case of multiple<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *=
 offsets. If non-null, dma_pfn_offset<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *=
 will be 0. */<br>
&gt; &gt; &gt; +#endif<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_dma_parameters *dma_=
parms;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct list_head=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dma_pools;=C2=A0 =C2=A0 =C2=A0 /* dma pools (if dma&#39;ble) */<=
br>
&gt; &gt;<br>
&gt; &gt; I&#39;ll defer to Christoph here, but I thought we were trying to=
 get rid of<br>
&gt; &gt; stuff like this from struct device, not add new things to it for =
dma<br>
&gt; Hi Greg,<br>
&gt; <br>
&gt; I wasn&#39;t aware of this policy.=C2=A0 I put it in &#39;struct devic=
e&#39; because<br>
&gt; just like the existing dma_pfn_offset; it seemed to be the only way to=
<br>
&gt; pull this off.=C2=A0 I&#39;ll certainly follow any ideas on alternativ=
e<br>
&gt; strategies from Christoph et al.<br>
&gt; <br>
&gt; &gt; apis.=C2=A0 And why is it a void *?<br>
&gt; Just wanted to minimize the number of lines I&#39;ve added to device.h=
, no<br>
&gt; other reason.<br>
<br>
How would using a real type make this more lines?=C2=A0 Never use a void *<=
br>
unless you have to, we want the compiler to check our errors for us :)<br><=
/blockquote><div><br></div><div>Got it; I did not need to define the struct=
 in device.h.=C2=A0 Will fix if this code makes it past v1 :-)</div><div><b=
r></div><div>Jim</div><div><br></div><div><br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<br>
thanks,<br>
<br>
greg k-h<br>
</blockquote></div></div>

--000000000000c2ec2405a614f0b7--

--===============7397478299287332320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7397478299287332320==--
