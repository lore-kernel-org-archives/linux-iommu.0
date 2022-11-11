Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BC528FA
	for <iommu@lists.linux.dev>; Fri, 11 Nov 2022 21:37:56 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id s20so3778123qkg.5
        for <iommu@lists.linux.dev>; Fri, 11 Nov 2022 13:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=70bGPbiqAKd6Lj1pvfQPegklyN+fxl8EXb9nnpTKORY=;
        b=LCFDZZp96QMSp2MflvI3wKXDOOyFAL4rJ/9RV5YRuGGm38PHTHZIUaRR0b7TIav77I
         ZFtKMKoBbMin+VIf3lzjALLzK2bGCHmH4nGCYYx+6m/sc/7yEbjocmQ1d42Z9C/iKA9j
         shfLHnoLIrulLtUaTCgJ4MfTyWqfN15N1+NuVg1uEewzATuuY0DdiapFdrgp8SiUV37Y
         xkfwPvAoONlGVebwBWlazjzjToC0PLptLZMvicURSWI2L1xofSy2KzP3sHmJDXQC8WI5
         BSZqK2ZEvNa1ezdor7Kldt+pzg4dnkSdhxtHpIDm94XsL1My7PfHa9k9uYxmTbQ0TnSk
         iyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70bGPbiqAKd6Lj1pvfQPegklyN+fxl8EXb9nnpTKORY=;
        b=m7N4veQyxT/e4YgYkVF+bpE85EpN+rsgO0fiIXQt6u0G6IlsCZY0/GbyH/4az3ljjz
         lMSVI2LjZyF2pgbghrJMcFpxuByzeQDwxgdbsYkpHn4PcxD7ETjUo66x1RRjLq4leanr
         jhgoVDaWlgmk1t/rvxC4LlkcoNTDQJPJT2aAfIoDHS8zjpoUnG5Kcvrp9Hp4Hzt4O+xD
         qIn7SDX1QmOzm5umVs0QAlBXjnhJdVp4ds3v6k+DiQL9WeQsW0+VrklvkeZdl/l43x3G
         VAEjKUVlJOMQ5LmA/qhqmxYY3U4fW8JS2OKmkP7sLBZfHTWeiL3GeDg+LrTWg1d7dong
         bvtA==
X-Gm-Message-State: ANoB5pm492Kdpf2oU1X0dPpy0BKLXzpMOYhEwoALT88n0WR0lBh8o9jp
	HaAYCFaVVHZPhaP86z4dI/Y=
X-Google-Smtp-Source: AA0mqf48Z6Ii+VzHnDMBVWN9P8PzYH/laMyIxHyHYRJVZB0TmCs0Vj2Y6KdY1dKXVjBoCJ64I0zHjA==
X-Received: by 2002:ae9:ef53:0:b0:6fa:4a82:1152 with SMTP id d80-20020ae9ef53000000b006fa4a821152mr2931568qkg.504.1668202675397;
        Fri, 11 Nov 2022 13:37:55 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m10-20020a05620a24ca00b006cbc6e1478csm2108327qkn.57.2022.11.11.13.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 13:37:54 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 11 Nov 2022 13:37:53 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Robin Murphy <robin.murphy@arm.com>
Cc: fenghua.yu@intel.com, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	janusz.krzysztofik@linux.intel.com, lucas.demarchi@intel.com
Subject: Re: [PATCH] hwmon/coretemp: Simplify platform device antics
Message-ID: <20221111213753.GA1059841@roeck-us.net>
References: <898dbb76a54aae6ca58ceefcab9ab18beeee2fff.1668096928.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <898dbb76a54aae6ca58ceefcab9ab18beeee2fff.1668096928.git.robin.murphy@arm.com>

On Thu, Nov 10, 2022 at 04:20:25PM +0000, Robin Murphy wrote:
> Coretemp's vestigial platform driver is odd. All the real work is done
> globally by the initcall and CPU hotplug notifiers, while the "driver"
> effectively just wraps an allocation and the registration of the hwmon
> interface in a long-winded round-trip through the driver core. The whole
> logic of dynamically creating and destroying platform devices to bring
> the interfaces up and down is fatally flawed right away, since it
> assumes platform_device_add() will synchronously bind the driver and set
> drvdata before it returns, thus results in a NULL dereference if
> drivers_autoprobe is turned off for the platform bus. Furthermore, the
> unusual approach of doing that from within a CPU hotplug notifier is
> also problematic. It's already commented in the code that it deadlocks
> suspend, but it also causes lockdep issues for other drivers or
> subsystems which may want to legitimately register a CPU hotplug
> notifier from a platform bus notifier.
> 
> All of these issues can be solved by ripping this questionable behaviour
> out completely, simply tying the platform devices to the lifetime of the
> module itself, and directly managing the hwmon interfaces from the
> hotplug notifiers. There is a slight user-visible change in that
> /sys/bus/platform/drivers/coretemp will no longer appear, and
> /sys/devices/platform/coretemp.n will remain present if package n is
> hotplugged off, but hwmon users should really only be looking for the
> presence of the hwmon interfaces, whose behaviour remains unchanged.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> I haven't been able to fully test hotplug since I only have a
> single-socket Intel system to hand.

Someone with access to hardware will have to validate this.

For both subject and description, please avoid terms like "antics",
"odd", or "questionable". Please describe the problem in neutral terms.

Thanks,
Guenter
