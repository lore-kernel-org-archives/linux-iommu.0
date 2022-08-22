Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE794621
	for <iommu@lists.linux.dev>; Mon, 22 Aug 2022 20:32:14 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id e21so10598829edc.7
        for <iommu@lists.linux.dev>; Mon, 22 Aug 2022 13:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=gUUJGDZZ7SmwoHkhrT602wMnsCfmfrGrVbXmH2wIM3g=;
        b=Z+tUKeClXChR4jRlQGg41fHbT2bJsJZqVxlH7TSDRnIKVcsWoXGws6FK/hz5EGuT4S
         yPu/tIYvMiV5u9nagc3sJ7K7VFdaJs3UH//tmuGoe95tcbMp5ov4mybmPAqUAwktzqOI
         V0PJNpbtkpzFVVxtumlOm80eN4+ci0qXNJMp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=gUUJGDZZ7SmwoHkhrT602wMnsCfmfrGrVbXmH2wIM3g=;
        b=3NQjfdDPg97g8jBwIMtybMBoysyAoD2quJiWyAqKqiyQ0Xxf/Bu53mM8hfL9btfYNa
         wSyxFC6hsKKpw/GeLBck3OF1PCyEGQ2w03JIhvvSxf2GfNTPyOJvMuQZM95WCqTpO3Q2
         LCIJh5uui0d3YnnqchdJ68tRXfNGXpPkiRf6+VAqONWcJvGE+vqZzZL1vquPqdRB+DMN
         fFJxouS/KVoaJH+DBykt92dInf7177hwX2C3yupplJwJ6wmLUbrGXud6IPuJHv7ATzVd
         GPdTXlAXRqLlCHNJIvN8Hdcf8b+QTiccfwXv9rVxg+Bips2JU3qa+jwVQrguFn5FqelZ
         XpEQ==
X-Gm-Message-State: ACgBeo1KZ02a2tO9xXKhtzdeEj5LukUb7Wwz1HLz+J3Uw8ciSJ7zCoYs
	cGrKVO8v5QxhUwj4A9QbKi29Rcjzmrf5bAfJK2U=
X-Google-Smtp-Source: AA6agR4DWnreQVYSufizdBSpnoZfnuc3VBeuhzYC25r2Oy0WUMszY6sM7SODJQdYIHa4SIVsRzU0NA==
X-Received: by 2002:a05:6402:42d3:b0:435:2c49:313d with SMTP id i19-20020a05640242d300b004352c49313dmr752966edc.86.1661200332993;
        Mon, 22 Aug 2022 13:32:12 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id y9-20020a50eb09000000b0043cc2c9f5adsm254368edp.40.2022.08.22.13.32.12
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 13:32:12 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id bs25so14621489wrb.2
        for <iommu@lists.linux.dev>; Mon, 22 Aug 2022 13:32:12 -0700 (PDT)
X-Received: by 2002:a05:6000:1541:b0:222:cf65:18d7 with SMTP id
 1-20020a056000154100b00222cf6518d7mr11504823wry.659.1661200321380; Mon, 22
 Aug 2022 13:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220819221616.2107893-1-saravanak@google.com> <20220819221616.2107893-4-saravanak@google.com>
In-Reply-To: <20220819221616.2107893-4-saravanak@google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Aug 2022 13:31:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wrf2k1gY9+B0WW6D2nhvSHNfWAQrW+y4Td=-u08xe+rQ@mail.gmail.com>
Message-ID: <CAD=FV=Wrf2k1gY9+B0WW6D2nhvSHNfWAQrW+y4Td=-u08xe+rQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] Revert "PM: domains: Delete usage of driver_deferred_probe_check_state()"
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
> This reverts commit 5a46079a96451cfb15e4f5f01f73f7ba24ef851a.
>
> Quite a few issues have been reported [1][2][3][4][5][6] on the original
> commit. While about half of them have been fixed, I'll need to fix the rest
> before driver_deferred_probe_check_state() can be deleted. So, revert the
> deletion for now.
>
> [1] - https://lore.kernel.org/all/DU0PR04MB941735271F45C716342D0410886B9@DU0PR04MB9417.eurprd04.prod.outlook.com/
> [2] - https://lore.kernel.org/all/CM6REZS9Z8AC.2KCR9N3EFLNQR@otso/
> [3] - https://lore.kernel.org/all/CAD=FV=XYVwaXZxqUKAuM5c7NiVjFz5C6m6gAHSJ7rBXBF94_Tg@mail.gmail.com/
> [4] - https://lore.kernel.org/all/Yvpd2pwUJGp7R+YE@euler/
> [5] - https://lore.kernel.org/lkml/20220601070707.3946847-2-saravanak@google.com/
> [6] - https://lore.kernel.org/all/CA+G9fYt_cc5SiNv1Vbse=HYY_+uc+9OYPZuJ-x59bROSaLN6fw@mail.gmail.com/
>
> Fixes: 5a46079a9645 ("PM: domains: Delete usage of driver_deferred_probe_check_state()")
> Reported-by: Peng Fan <peng.fan@nxp.com>
> Reported-by: Luca Weiss <luca.weiss@fairphone.com>
> Reported-by: Doug Anderson <dianders@chromium.org>
> Reported-by: Colin Foster <colin.foster@in-advantage.com>
> Reported-by: Tony Lindgren <tony@atomide.com>
> Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Douglas Anderson <dianders@chromium.org>
