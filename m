Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262E34A3B
	for <iommu@lists.linux.dev>; Mon, 22 Aug 2022 20:35:14 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id n7so5409656ejh.2
        for <iommu@lists.linux.dev>; Mon, 22 Aug 2022 13:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kg3si/WqZ2UuGBgeFpee5ChSULBO+SUIk5ZvymvbTKI=;
        b=HIdP2i1AcaynwhPmy7b1DkZMhAXV/hh+1VoI2Ojp/UHcpa7E1+BZ7UE+hb260Uw0JK
         +ITfNjAdpzm+GhURNGNdHBfuXdPu1Y68bYDqdf+p7oazv0UgB5+SN/jzwovYQPZnHkXp
         85gT+RgQD+3G/YWWOk4hx1ZHKELEo92QzDAKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kg3si/WqZ2UuGBgeFpee5ChSULBO+SUIk5ZvymvbTKI=;
        b=HnuEo/8Xib8fXpo7OcaBn7Jin6DVIjJUGWYyFSXCguAMsk1DydW841bHYsr41c36Q0
         odKX6v/ICB0zWsErM+Qg0HEilknDYyI9dfMGmmZyCruXjYKCJEi7lP5KD8y1mX75XQwI
         FKW2AyckfcKkOvy/uNFp6WZys3/d/JuMYRtOGi4d5oE8UXUKUc6Dtr1OWCEMitWCCmJ0
         OgBC+VDREkB9muedWyT/JL0TWZrTXweZy7gSNkpIFDt1MLXV2tXyvq7W8CZ2UNS2P4gU
         6Lj7n3F/BiWgGwrXVXwYlQFO2rmHJNU1SLWtlQuhQg3FwF+Ucxh9yCGqymykEryccR6T
         KMRA==
X-Gm-Message-State: ACgBeo3gMlZbkdbIxYbveSGQ4i9RHD9fxXa0MrzYDtkCd0I4A9EPdBDT
	MwBaGVIAC+fX+X9EP/rQX+ml86N0lE89oUeoaI0=
X-Google-Smtp-Source: AA6agR7lhSgbqKH7K9bOqC7u2+VW2yGiPaSnpOwvp0icrUT8TcGToqZzzLzyGBIcXT5G7dTZZjC4OA==
X-Received: by 2002:a17:907:7e93:b0:73d:80a2:df42 with SMTP id qb19-20020a1709077e9300b0073d80a2df42mr4600779ejc.524.1661200512277;
        Mon, 22 Aug 2022 13:35:12 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id kw5-20020a170907770500b0073c82539183sm5871118ejc.91.2022.08.22.13.35.11
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 13:35:12 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id k17so6179184wmr.2
        for <iommu@lists.linux.dev>; Mon, 22 Aug 2022 13:35:11 -0700 (PDT)
X-Received: by 2002:a05:600c:4c06:b0:3a5:4eec:eb4b with SMTP id
 d6-20020a05600c4c0600b003a54eeceb4bmr59560wmp.151.1661200501419; Mon, 22 Aug
 2022 13:35:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220819221616.2107893-1-saravanak@google.com> <20220819221616.2107893-2-saravanak@google.com>
In-Reply-To: <20220819221616.2107893-2-saravanak@google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Aug 2022 13:34:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WfrBAbO8pKmema_8nPFHTNc5nZE2X3RWpT8S53PiCkGQ@mail.gmail.com>
Message-ID: <CAD=FV=WfrBAbO8pKmema_8nPFHTNc5nZE2X3RWpT8S53PiCkGQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Revert "driver core: Delete driver_deferred_probe_check_state()"
To: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, 
	Len Brown <len.brown@intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Peng Fan <peng.fan@nxp.com>, 
	Luca Weiss <luca.weiss@fairphone.com>, Colin Foster <colin.foster@in-advantage.com>, 
	Tony Lindgren <tony@atomide.com>, Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Jean-Philippe Brucker <jpb@kernel.org>, kernel-team@android.com, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	iommu@lists.linux.dev, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, Aug 19, 2022 at 3:16 PM Saravana Kannan <saravanak@google.com> wrote:
>
> This reverts commit 9cbffc7a59561be950ecc675d19a3d2b45202b2b.
>
> There are a few more issues to fix that have been reported in the thread
> for the original series [1]. We'll need to fix those before this will work.
> So, revert it for now.
>
> [1] - https://lore.kernel.org/lkml/20220601070707.3946847-1-saravanak@google.com/
>
> Fixes: 9cbffc7a5956 ("driver core: Delete driver_deferred_probe_check_state()")
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/dd.c             | 30 ++++++++++++++++++++++++++++++
>  include/linux/device/driver.h |  1 +
>  2 files changed, 31 insertions(+)

Tested-by: Douglas Anderson <dianders@chromium.org>
