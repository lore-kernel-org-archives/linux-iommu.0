Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1C9C433EF
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 16:13:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C2122404F7;
	Mon, 25 Apr 2022 16:13:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kSyEUX2rgrHa; Mon, 25 Apr 2022 16:13:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 74BD340138;
	Mon, 25 Apr 2022 16:13:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E23AC0032;
	Mon, 25 Apr 2022 16:13:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 679ADC002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 16:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 55A1A60E6D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 16:13:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nRn_Bw9UA8Uu for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 16:13:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 37DAC60E6B
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 16:13:31 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id l18so3967049ejc.7
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 09:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=GlOlAhS+OLlgHOZ0Skxe6Lfb/bGYsvoHqLs8XtmumJU=;
 b=SnnXtcb27udbuQaeffIv6evHq0/Gn57swPViAVrmSy/us95OXTrnJeAdcz7cFH4lBn
 TfMg85bpUIf4t++h8FJ3BksIiqxjMZFojsl8fkcKxQ6WqAyWi2H1osm+qjhhpXSb2xSf
 eGF8nCIh46iZUcoBnjalnAO3SXG9fhhn9QHxIOlRVxW4dnR4jxmPJLxIE+j8zd6f4rKb
 KPJsQnt+MO8GsbvO2lz2d38G/P6GoNlXVYP9nBMiq3hbc+DGbRPnaid66Rz8+r5lW0PP
 CtK1dh/9TmhksmpMA05tGRcT7xyomeNpdbObbYJoQWBGHVcNESCVfCwLTUPm27eKa9OC
 yPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GlOlAhS+OLlgHOZ0Skxe6Lfb/bGYsvoHqLs8XtmumJU=;
 b=Dj/vrPCOmxmLpIeKl5hMmjvHK4zgU6NsTfx5uD8vWOJnNUmB/wcMsFkVLXJ3P1paGN
 kM3avjPevy7OZh2bijKikYh7BqA9GJ5SwO+hYeIu4Ax8YLFWFZPD6/cYQQEyWXjplMWR
 xCB/kHrwoGweDGGgwA2h6CBccszENQO9Q6vmNeu9Fds5lOHusdj6Zw7ty3NxkS6kNF0N
 sWKBbQW+kvhGQ0cqsNoJyulwBuDy9BJtueWeL95GLXbS086nCpWJQ3Xu3yRgLd9dMMun
 /I0xOKTY5oppaeLoAtepkJZkdcx/4ER+TrrLthtFR96bJ42ecOLhr+ujg1PWpZjwepis
 b2ag==
X-Gm-Message-State: AOAM531c+sDsnlkeJMkHbP0Gk8jLq5fjC5BG5aGyxssRv6lozxHan0Kz
 YHRHBMCop/WDgfywZctC/hTxWQ==
X-Google-Smtp-Source: ABdhPJyOGh9q3n9fkZwfv1B3DW38Srr0+LaLCQTU7rtck/9ORV637dA3G4znxrSrihaNj4rdwot81w==
X-Received: by 2002:a17:907:2da8:b0:6f3:75e1:f9b1 with SMTP id
 gt40-20020a1709072da800b006f375e1f9b1mr10916437ejc.139.1650903209383; 
 Mon, 25 Apr 2022 09:13:29 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 o22-20020a170906289600b006e44a0c1105sm3763114ejd.46.2022.04.25.09.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Apr 2022 09:13:28 -0700 (PDT)
Date: Mon, 25 Apr 2022 17:13:02 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YmbIjnHtibY7n4Wb@myrica>
References: <tencent_76E043C4D1B6A21A5253579A61034107EB06@qq.com>
 <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
 <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica>
 <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica> <20220425083444.00af5674@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220425083444.00af5674@jacob-builder>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, will@kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 zhangfei.gao@linaro.org, Thomas Gleixner <tglx@linutronix.de>,
 robin.murphy@arm.com
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

Hi Jacob,

On Mon, Apr 25, 2022 at 08:34:44AM -0700, Jacob Pan wrote:
> Hi Jean-Philippe,
> 
> On Mon, 25 Apr 2022 15:26:40 +0100, Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> 
> > On Mon, Apr 25, 2022 at 07:18:36AM -0700, Dave Hansen wrote:
> > > On 4/25/22 06:53, Jean-Philippe Brucker wrote:  
> > > > On Sat, Apr 23, 2022 at 07:13:39PM +0800, zhangfei.gao@foxmail.com
> > > > wrote:  
> > > >>>> On 5.17
> > > >>>> fops_release is called automatically, as well as
> > > >>>> iommu_sva_unbind_device. On 5.18-rc1.
> > > >>>> fops_release is not called, have to manually call close(fd)  
> > > >>> Right that's weird  
> > > >> Looks it is caused by the fix patch, via mmget, which may add
> > > >> refcount of fd.  
> > > > Yes indirectly I think: when the process mmaps the queue,
> > > > mmap_region() takes a reference to the uacce fd. That reference is
> > > > released either by explicit close() or munmap(), or by exit_mmap()
> > > > (which is triggered by mmput()). Since there is an mm->fd dependency,
> > > > we cannot add a fd->mm dependency, so no mmget()/mmput() in
> > > > bind()/unbind().
> > > > 
> > > > I guess we should go back to refcounted PASIDs instead, to avoid
> > > > freeing them until unbind().  
> > > 
> > > Yeah, this is a bit gnarly for -rc4.  Let's just make sure there's
> > > nothing else simple we can do.
> > > 
> > > How does the IOMMU hardware know that all activity to a given PASID is
> > > finished?  That activity should, today, be independent of an mm or a
> > > fd's lifetime.  
> > 
> > In the case of uacce, it's tied to the fd lifetime: opening an accelerator
> > queue calls iommu_sva_bind_device(), which sets up the PASID context in
> > the IOMMU. Closing the queue calls iommu_sva_unbind_device() which
> > destroys the PASID context (after the device driver stopped all DMA for
> > this PASID).
> > 
> For VT-d, it is essentially the same flow except managed by the individual
> drivers such as DSA.
> If free() happens before unbind(), we deactivate the PASIDs and suppress
> faults from the device. When the unbind finally comes, we finalize the
> PASID teardown. It seems we have a need for an intermediate state where
> PASID is "pending free"?

Yes we do have that state, though I'm not sure we need to make it explicit
in the ioasid allocator.

Could we move mm_pasid_drop() to __mmdrop() instead of __mmput()?  For Arm
we do need to hold the mm_count until unbind(), and mmgrab()/mmdrop() is
also part of Lu's rework [1].

Thanks,
Jean

[1] https://lore.kernel.org/linux-iommu/20220421052121.3464100-9-baolu.lu@linux.intel.com/
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
