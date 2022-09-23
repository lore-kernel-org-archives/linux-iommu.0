Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E505D3D90
	for <iommu@lists.linux.dev>; Fri, 23 Sep 2022 15:28:12 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id f23so487446plr.6
        for <iommu@lists.linux.dev>; Fri, 23 Sep 2022 08:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date;
        bh=5r7foWQmgnElkTtlj2t11gwXHrDcKejvsb3U8D3RKiE=;
        b=CME6FiUdsbwMGLzNgML6WHHl1lM9nFZE7vx7IzFUZRa/XbKB8NDkcto6BiUp759bV9
         7r862R6CjsSoGCnmpL+41+hVunsCJjoGMXymp0R7Y8Zqxaed1kZEIL0i1tno1wiFta14
         jDYVEVndeuszvfDVLmcN1ZWzzcJYK5yleexxpDYQ2kwKg8ZV0BOerRBch2oONh0denaD
         lMDWdFMkd7McKfKnErgCx/kVfT1S64SKIpeAmn0fG0ljoRFoAciqPfTwVNQstTTm38vA
         l20Vf9rljn53hxlAXjYXbP3NGVmpwqPmgsukOtjbJ7qYlDo6jO0zGDdno3Ho30fJb8kq
         Xvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=5r7foWQmgnElkTtlj2t11gwXHrDcKejvsb3U8D3RKiE=;
        b=g0QXl5sUVUl1xsYQOnh3Y7P3VFTvNd+H0qJhua7HDbNtZt9q7v9mcksTzRL0D/4fDw
         WdjJRJRlS54cP9T8jfRqdK8iS4le/NFnjD8ZVij5L8Xju8RDAtHHEkFHxx6KAlL3vddn
         JxBn0/sRahTS8y9vFrpOJqaFTDY0/61Wl1BW1A/7sl+LOnQwR6sFem1TaGMFo6hHxjhp
         wSj/UcsueZBBQRpm6WjeRPxYc+u0K3Kh/P3z0IOXUn4bUPb1t6lDgyuXaCqyAs/5ExeI
         UsKKCBUhsFt1U6v5nES9fpiGPglvATOgkWXUFx16Hwz5n3j1gC51YoE5NxEHplAWRfhT
         ZkCA==
X-Gm-Message-State: ACrzQf2nixBwXrCE3HvDTC+2w8asCd2tnJdRamewn4a8hByLMY6fWmDK
	I/zlsSA0+AsdqjpSdGVJLdU=
X-Google-Smtp-Source: AMsMyM6Q+wxHrhd5Z1U8d4zBgf7c0opVTeT/ajm9hG/mwLKjWxsSuYka/83LtH8DJGgJk6NpllHvbg==
X-Received: by 2002:a17:902:f08a:b0:176:b477:8be0 with SMTP id p10-20020a170902f08a00b00176b4778be0mr9293590pla.66.1663946892310;
        Fri, 23 Sep 2022 08:28:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a15-20020a17090a740f00b002036006d65bsm1688463pjg.39.2022.09.23.08.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 08:28:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 23 Sep 2022 08:28:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kbuild@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Ming Lin <ming.l@ssi.samsung.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] lib/sg_pool: change module_init(sg_pool_init) to
 subsys_initcall
Message-ID: <20220923152809.GA455235@roeck-us.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 23, 2022 at 08:38:35PM +0900, Masahiro Yamada wrote:
> sg_alloc_table_chained() is called by several drivers, but if it is
> called before sg_pool_init(), it results in a NULL pointer dereference
> in sg_pool_alloc().
> 
> Since commit 9b1d6c895002 ("lib: scatterlist: move SG pool code from
> SCSI driver to lib/sg_pool.c"), we rely on module_init(sg_pool_init)
> is invoked before other module_init calls but this assumption is
> fragile.
> 
> I slightly changed the link order while Kbuild refactoring Kbuild,
> then uncovered this issue. I should keep the current link order, but
> depending on a specific call order among module_init is so fragine.
> 
> We usually define the init order by specifying *_initcall correctly,
> or delay the driver probing by returning -EPROBE_DEFER.
> 
> Change module_initcall() to subsys_initcall(), and also delete the
> pointless module_exit() because lib/sg_pool.c is always compiled as
> built-in. (CONFIG_SG_POOL is bool)
> 
> Link: https://lore.kernel.org/all/20220921043946.GA1355561@roeck-us.net/
> Link: https://lore.kernel.org/all/8e70837d-d859-dfb2-bf7f-83f8b31467bc@samsung.com/
> Fixes: 9b1d6c895002 ("lib: scatterlist: move SG pool code from SCSI driver to lib/sg_pool.c")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
