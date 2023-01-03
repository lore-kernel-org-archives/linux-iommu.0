Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6738F6B;
	Tue,  3 Jan 2023 21:25:59 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id e205so28119150oif.11;
        Tue, 03 Jan 2023 13:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=694YS9SOspcSvtjCObhPD7jOKavy/ZO9Dr+Cqvpl+vI=;
        b=JGSSRyqfzLY10qJoJZA53zCBOOVi51oS1bxGkRM7+xCO0XCMmQMhO115PlCOQwA+H2
         ml8vZX6d0382kl7/uIzUiAqhKP+P+rKBqhUQyTyIdF+VE7s0qi+DhtJWqIOM4BsP78/f
         fHLV2o1GkHlANfL+mPMHlEjFPcg7zbfjt3OkL8rB/pDo3R+L5vGoXudaTkjtM3VEP3Cv
         DWFI7yAyBojxBJ7kyLWk/6rewan5w2biWG/MjNZjrS/PqybYChrneQmuyejOsgYgEa1/
         dPtAu/bgYsFkeBm+aA2rz/hN8VhJ29eVTWK3pfuY9qpXLbDFKm0zYtVWD7pVVjWDIpYm
         BLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=694YS9SOspcSvtjCObhPD7jOKavy/ZO9Dr+Cqvpl+vI=;
        b=VrLrJ2MPhRS9PU9P9CgJV+FxzCmy0JRD2BRcK+dq4wlDlnaYPdyeJiLfwyizZXLCGu
         wHYn7BokXGDkY1YNI86uudwbXHTm+rNXshdNNNXSXiCqN9eNy0I6QdZQyh8c8PdMAs7f
         oeeRn36GmtmFiWlEVD+0elQsKTjdyA+Ct9Wh7qTNHxEgBuvfswlT6ALWGzNg8nysB24l
         APGTQFta6PxCo1ZJ2BJqUnf2qRnmZJmV8KVV/9GLZ6OX58w8Tf7vZh0jcr+yhHaPf7uh
         UYHJyxTaWeKE5Fs5uvX+sDvWBsXS4WgxKJc/xhYGuK5tRG61aKJJw8WcENjHKGYX5ZUR
         sNCw==
X-Gm-Message-State: AFqh2kqEETPK8DhTH0Sxmt+0/+GpghSTgSvUEfz2w5fPI8/rcW+LF++8
	XJJzk9UDqn4gIALPzq2kwgA=
X-Google-Smtp-Source: AMrXdXt9/RsocZzW+qAGcHc4ol9X0vz443IWbjZYCBf/2L7JyiZ8K61og9r5F7/8YIIMKIYOpD34kw==
X-Received: by 2002:aca:c246:0:b0:35e:2dc2:ca78 with SMTP id s67-20020acac246000000b0035e2dc2ca78mr18984148oif.57.1672781158958;
        Tue, 03 Jan 2023 13:25:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o20-20020a0568080bd400b0036305193c4bsm13613354oik.3.2023.01.03.13.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 13:25:58 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 3 Jan 2023 13:25:57 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <jdelvare@suse.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Robin Murphy <robin.murphy@arm.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, regressions@lists.linux.dev
Subject: Re: [PATCH v2] hwmon/coretemp: Simplify platform device handling
Message-ID: <20230103212557.GA213597@roeck-us.net>
References: <20230103114620.15319-1-janusz.krzysztofik@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103114620.15319-1-janusz.krzysztofik@linux.intel.com>

On Tue, Jan 03, 2023 at 12:46:20PM +0100, Janusz Krzysztofik wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> Coretemp's platform driver is unconventional. All the real work is done
> globally by the initcall and CPU hotplug notifiers, while the "driver"
> effectively just wraps an allocation and the registration of the hwmon
> interface in a long-winded round-trip through the driver core.  The whole
> logic of dynamically creating and destroying platform devices to bring
> the interfaces up and down is error prone, since it assumes
> platform_device_add() will synchronously bind the driver and set drvdata
> before it returns, thus results in a NULL dereference if drivers_autoprobe
> is turned off for the platform bus. Furthermore, the unusual approach of
> doing that from within a CPU hotplug notifier, already commented in the
> code that it deadlocks suspend, also causes lockdep issues for other
> drivers or subsystems which may want to legitimately register a CPU
> hotplug notifier from a platform bus notifier.
> 
> All of these issues can be solved by ripping this unusual behaviour out
> completely, simply tying the platform devices to the lifetime of the
> module itself, and directly managing the hwmon interfaces from the
> hotplug notifiers. There is a slight user-visible change in that
> /sys/bus/platform/drivers/coretemp will no longer appear, and
> /sys/devices/platform/coretemp.n will remain present if package n is
> hotplugged off, but hwmon users should really only be looking for the
> presence of the hwmon interfaces, whose behaviour remains unchanged.
> 
> v2: describe the problem in neutral terms
> 
> Link: https://lore.kernel.org/lkml/20220922101036.87457-1-janusz.krzysztofik@linux.intel.com/
> Link: https://gitlab.freedesktop.org/drm/intel/issues/6641
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/coretemp.c | 128 ++++++++++++++++++---------------------
>  1 file changed, 58 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index ca7a9b373bbd6..3e440ebe2508c 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -588,66 +588,49 @@ static void coretemp_remove_core(struct platform_data *pdata, int indx)
>  		ida_free(&pdata->ida, indx - BASE_SYSFS_ATTR_NO);
>  }
>  
> -static int coretemp_probe(struct platform_device *pdev)
> +static int coretemp_device_add(int zoneid)
>  {
> -	struct device *dev = &pdev->dev;
> +	struct platform_device *pdev;
>  	struct platform_data *pdata;
> +	int err;
>  
>  	/* Initialize the per-zone data structures */
> -	pdata = devm_kzalloc(dev, sizeof(struct platform_data), GFP_KERNEL);
> +	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
>  	if (!pdata)
>  		return -ENOMEM;
>  
> -	pdata->pkg_id = pdev->id;
> +	pdata->pkg_id = zoneid;
>  	ida_init(&pdata->ida);
> -	platform_set_drvdata(pdev, pdata);
>  
> -	pdata->hwmon_dev = devm_hwmon_device_register_with_groups(dev, DRVNAME,
> -								  pdata, NULL);
> -	return PTR_ERR_OR_ZERO(pdata->hwmon_dev);
> -}
> -
> -static int coretemp_remove(struct platform_device *pdev)
> -{
> -	struct platform_data *pdata = platform_get_drvdata(pdev);
> -	int i;
> +	pdev = platform_device_alloc(DRVNAME, zoneid);
> +	if (!pdev) {
> +		err = -ENOMEM;
> +		goto err_free_pdata;
> +	}
>  
> -	for (i = MAX_CORE_DATA - 1; i >= 0; --i)
> -		if (pdata->core_data[i])
> -			coretemp_remove_core(pdata, i);
> +	err = platform_device_add(pdev);
> +	if (err)
> +		goto err_put_dev;
>  
> -	ida_destroy(&pdata->ida);
> +	platform_set_drvdata(pdev, pdata);
> +	zone_devices[zoneid] = pdev;
>  	return 0;
> -}
>  
> -static struct platform_driver coretemp_driver = {
> -	.driver = {
> -		.name = DRVNAME,
> -	},
> -	.probe = coretemp_probe,
> -	.remove = coretemp_remove,
> -};
> +err_put_dev:
> +	platform_device_put(pdev);
> +err_free_pdata:
> +	kfree(pdata);
> +	return err;
> +}
>  
> -static struct platform_device *coretemp_device_add(unsigned int cpu)
> +static void coretemp_device_remove(int zoneid)
>  {
> -	int err, zoneid = topology_logical_die_id(cpu);
> -	struct platform_device *pdev;
> -
> -	if (zoneid < 0)
> -		return ERR_PTR(-ENOMEM);
> -
> -	pdev = platform_device_alloc(DRVNAME, zoneid);
> -	if (!pdev)
> -		return ERR_PTR(-ENOMEM);
> -
> -	err = platform_device_add(pdev);
> -	if (err) {
> -		platform_device_put(pdev);
> -		return ERR_PTR(err);
> -	}
> +	struct platform_device *pdev = zone_devices[zoneid];
> +	struct platform_data *pdata = platform_get_drvdata(pdev);
>  
> -	zone_devices[zoneid] = pdev;
> -	return pdev;
> +	ida_destroy(&pdata->ida);
> +	kfree(pdata);
> +	platform_device_unregister(pdev);
>  }
>  
>  static int coretemp_cpu_online(unsigned int cpu)
> @@ -671,7 +654,10 @@ static int coretemp_cpu_online(unsigned int cpu)
>  	if (!cpu_has(c, X86_FEATURE_DTHERM))
>  		return -ENODEV;
>  
> -	if (!pdev) {
> +	pdata = platform_get_drvdata(pdev);
> +	if (!pdata->hwmon_dev) {
> +		struct device *hwmon;
> +
>  		/* Check the microcode version of the CPU */
>  		if (chk_ucode_version(cpu))
>  			return -EINVAL;
> @@ -682,9 +668,11 @@ static int coretemp_cpu_online(unsigned int cpu)
>  		 * online. So, initialize per-pkg data structures and
>  		 * then bring this core online.
>  		 */
> -		pdev = coretemp_device_add(cpu);
> -		if (IS_ERR(pdev))
> -			return PTR_ERR(pdev);
> +		hwmon = hwmon_device_register_with_groups(&pdev->dev, DRVNAME,
> +							  pdata, NULL);
> +		if (IS_ERR(hwmon))
> +			return PTR_ERR(hwmon);
> +		pdata->hwmon_dev = hwmon;
>  
>  		/*
>  		 * Check whether pkgtemp support is available.
> @@ -694,7 +682,6 @@ static int coretemp_cpu_online(unsigned int cpu)
>  			coretemp_add_core(pdev, cpu, 1);
>  	}
>  
> -	pdata = platform_get_drvdata(pdev);
>  	/*
>  	 * Check whether a thread sibling is already online. If not add the
>  	 * interface for this CPU core.
> @@ -713,18 +700,14 @@ static int coretemp_cpu_offline(unsigned int cpu)
>  	struct temp_data *tdata;
>  	int i, indx = -1, target;
>  
> -	/*
> -	 * Don't execute this on suspend as the device remove locks
> -	 * up the machine.
> -	 */
> +	/* No need to tear down any interfaces for suspend */
>  	if (cpuhp_tasks_frozen)
>  		return 0;
>  
>  	/* If the physical CPU device does not exist, just return */
> -	if (!pdev)
> -		return 0;
> -
>  	pd = platform_get_drvdata(pdev);
> +	if (!pd->hwmon_dev)
> +		return 0;
>  
>  	for (i = 0; i < NUM_REAL_CORES; i++) {
>  		if (pd->cpu_map[i] == topology_core_id(cpu)) {
> @@ -756,13 +739,14 @@ static int coretemp_cpu_offline(unsigned int cpu)
>  	}
>  
>  	/*
> -	 * If all cores in this pkg are offline, remove the device. This
> -	 * will invoke the platform driver remove function, which cleans up
> -	 * the rest.
> +	 * If all cores in this pkg are offline, remove the interface.
>  	 */
> +	tdata = pd->core_data[PKG_SYSFS_ATTR_NO];
>  	if (cpumask_empty(&pd->cpumask)) {
> -		zone_devices[topology_logical_die_id(cpu)] = NULL;
> -		platform_device_unregister(pdev);
> +		if (tdata)
> +			coretemp_remove_core(pd, PKG_SYSFS_ATTR_NO);
> +		hwmon_device_unregister(pd->hwmon_dev);
> +		pd->hwmon_dev = NULL;
>  		return 0;
>  	}
>  
> @@ -770,7 +754,6 @@ static int coretemp_cpu_offline(unsigned int cpu)
>  	 * Check whether this core is the target for the package
>  	 * interface. We need to assign it to some other cpu.
>  	 */
> -	tdata = pd->core_data[PKG_SYSFS_ATTR_NO];
>  	if (tdata && tdata->cpu == cpu) {
>  		target = cpumask_first(&pd->cpumask);
>  		mutex_lock(&tdata->update_lock);
> @@ -789,7 +772,7 @@ static enum cpuhp_state coretemp_hp_online;
>  
>  static int __init coretemp_init(void)
>  {
> -	int err;
> +	int i, err;
>  
>  	/*
>  	 * CPUID.06H.EAX[0] indicates whether the CPU has thermal
> @@ -805,20 +788,22 @@ static int __init coretemp_init(void)
>  	if (!zone_devices)
>  		return -ENOMEM;
>  
> -	err = platform_driver_register(&coretemp_driver);
> -	if (err)
> -		goto outzone;
> +	for (i = 0; i < max_zones; i++) {
> +		err = coretemp_device_add(i);
> +		if (err)
> +			goto outzone;
> +	}
>  
>  	err = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hwmon/coretemp:online",
>  				coretemp_cpu_online, coretemp_cpu_offline);
>  	if (err < 0)
> -		goto outdrv;
> +		goto outzone;
>  	coretemp_hp_online = err;
>  	return 0;
>  
> -outdrv:
> -	platform_driver_unregister(&coretemp_driver);
>  outzone:
> +	while (i--)
> +		coretemp_device_remove(i);
>  	kfree(zone_devices);
>  	return err;
>  }
> @@ -826,8 +811,11 @@ module_init(coretemp_init)
>  
>  static void __exit coretemp_exit(void)
>  {
> +	int i;
> +
>  	cpuhp_remove_state(coretemp_hp_online);
> -	platform_driver_unregister(&coretemp_driver);
> +	for (i = 0; i < max_zones; i++)
> +		coretemp_device_remove(i);
>  	kfree(zone_devices);
>  }
>  module_exit(coretemp_exit)
