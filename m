Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450772590
	for <iommu@lists.linux.dev>; Tue, 26 Jul 2022 14:38:25 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id bn9so9571594wrb.9
        for <iommu@lists.linux.dev>; Tue, 26 Jul 2022 07:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WpHEQnE8K/vPoI4Otp4u/E57Oasf5iTB9YBte/yldMI=;
        b=7CVCq+I5hrs4TLUEzZY8XHzi6kbr7r8fEpUkokl983SEiHVraFEdGolZB+L8pezqaS
         M4dRm+5sOuWOt0vjfmqo4E1bmWq+8H59Mx4UZBBiawXVP95lUvOWpHsnlcu3XiJoq1Y+
         YVPLYWj3+k8oTKAnWvgbwHdbfOjIn6deg9YiMgHhCAff5xhZ4ZS5mO5rZHx27atdNvgH
         7TslBRjzvM6a0TOjDNHOazhA+nGvmHAg+NSVKj3SAP9mHTC8/vaLvA55Ov7HhleK+i8y
         lxArgl/yckcxSO0wdMFyAaLBHkUoNPJT81XI3g2YKDSYa7YdtZyKNRggIua4RNlDI8v4
         4bQQ==
X-Gm-Message-State: AJIora9/G9VFyTc7H7ZYuMIuUOCxI05Qm/rpMCkSNHqRRcvA2AwKMczZ
	l/P/jUIjALu65ek8MsNmA60=
X-Google-Smtp-Source: AGRyM1uNrqBOWOIEvwQhVpPiHZP6UanlaaWN/rdWs5pVkMRmu7BOIZXnafEasMFfzIq/SAfWo73ZKA==
X-Received: by 2002:adf:db8e:0:b0:21e:4536:a934 with SMTP id u14-20020adfdb8e000000b0021e4536a934mr11377937wri.331.1658846303394;
        Tue, 26 Jul 2022 07:38:23 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r11-20020a5d498b000000b0021e42e7c7dbsm15037988wrq.83.2022.07.26.07.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 07:38:22 -0700 (PDT)
Date: Tue, 26 Jul 2022 14:38:21 +0000
From: Wei Liu <wei.liu@kernel.org>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Stephen Hemminger <sthemmin@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"samuel@sholland.org" <samuel@sholland.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH 1/1] iommu/hyper-v: Use helper instead of directly
 accessing affinity
Message-ID: <20220726143821.ezgm5quwcdsagpwf@liuwe-devbox-debian-v2>
References: <1658796820-2261-1-git-send-email-mikelley@microsoft.com>
 <Yt+Uro8y219/MNFE@8bytes.org>
 <20220726130909.jnj5etogffm4b2c5@liuwe-devbox-debian-v2>
 <PH0PR21MB30257E59393883842CDE0992D7949@PH0PR21MB3025.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB30257E59393883842CDE0992D7949@PH0PR21MB3025.namprd21.prod.outlook.com>

On Tue, Jul 26, 2022 at 01:48:35PM +0000, Michael Kelley (LINUX) wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Tuesday, July 26, 2022 6:09 AM
> > 
> > On Tue, Jul 26, 2022 at 09:15:58AM +0200, Joerg Roedel wrote:
> > > Hi Michael,
> > >
> > > On Mon, Jul 25, 2022 at 05:53:40PM -0700, Michael Kelley wrote:
> > > > Recent changes to solve inconsistencies in handling IRQ masks #ifdef
> > > > out the affinity field in irq_common_data for non-SMP configurations.
> > > > The current code in hyperv_irq_remapping_alloc() gets a compiler error
> > > > in that case.
> > > >
> > > > Fix this by using the new irq_data_update_affinity() helper, which
> > > > handles the non-SMP case correctly.
> > > >
> > > > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > >
> > > Please add a fixes tag.
> > >
> > > Where is the change which breaks this currently, in some subsystem tree
> > > or already upstream?
> > >
> > 
> > The offending patch aa081358 is in linux-next.
> > 
> > > In case it is still in a maintainers tree, this patch should be applied
> > > there. Here is my
> > >
> > > Acked-by: Joerg Roedel <jroedel@suse.de>
> > 
> > I can take this patch via hyperv-next. This is a good improvement
> > anyway.
> 
> I don't think this patch should go via hyperv-next.  The helper
> function is introduced in the linux-next patch in the irq/irqchip-next tree,
> so this patch should go through irq/irqchip-next to avoid creating an
> interdependency.

This is fine too.

Wei.
