From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Reparenting a platform device
Date: Thu, 5 Apr 2012 10:42:58 +0200
Message-ID: <20120405084258.GA19798@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2477958649242507229=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============2477958649242507229==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I have a device tree where I have a GART device and a DRM device which uses
the GART. The GART is implemented by an IOMMU driver (tegra-gart) and
requires the user device to be a child of the GART device (it explicitly
checks for this when the user device is attached).

I've tried two alternatives to achieve this: create the GART device in the
user driver's .probe() function and explicitly set the DRM device's parent
to the resulting platform device like so:

	gart = platform_device_alloc(...);
	...
	pdev->dev.parent = &gart->dev;

The alternative is to use the device tree to look up the GART device node and
resolve it to the corresponding struct device:

	gart_node = of_parse_phandle(drm->dev->of_node, "gart-parent", 0);
	gart = bus_find_device(drm->dev->bus, NULL, gart_node, match_of_node);

Where match_of_node matches each struct device's .of_node field to the
gart_node.

Both of these variants seem to work, and the DRM device can be properly
attached to the GART device. However, after the DRM driver's .probe() exits,
I get the following error:

	[   25.579261] ------------[ cut here ]------------
	[   25.583895] WARNING: at /home/thierry.reding/src/kernel/linux-ipmp.git/kernel/mutex-debug.c:78 debug_mutex_unlock+0x114/0x128()
	[   25.595352] Modules linked in: tegra_drm(+) cfbfillrect cfbimgblt cfbcopyarea drm_kms_helper drm fb pwm_tegra pwm_bl backlight
	[   25.606821] [<c0013c54>] (unwind_backtrace+0x0/0xf8) from [<c0027bcc>] (warn_slowpath_common+0x4c/0x64)
	[   25.616207] [<c0027bcc>] (warn_slowpath_common+0x4c/0x64) from [<c0027c00>] (warn_slowpath_null+0x1c/0x24)
	[   25.625853] [<c0027c00>] (warn_slowpath_null+0x1c/0x24) from [<c00667fc>] (debug_mutex_unlock+0x114/0x128)
	[   25.635508] [<c00667fc>] (debug_mutex_unlock+0x114/0x128) from [<c03bee2c>] (__mutex_unlock_slowpath+0x84/0x140)
	[   25.645680] [<c03bee2c>] (__mutex_unlock_slowpath+0x84/0x140) from [<c02149b4>] (__driver_attach+0x78/0x90)
	[   25.655412] [<c02149b4>] (__driver_attach+0x78/0x90) from [<c0213128>] (bus_for_each_dev+0x50/0x7c)
	[   25.664449] [<c0213128>] (bus_for_each_dev+0x50/0x7c) from [<c0214038>] (bus_add_driver+0x174/0x234)
	[   25.673572] [<c0214038>] (bus_add_driver+0x174/0x234) from [<c0214e7c>] (driver_register+0x78/0x12c)
	[   25.682696] [<c0214e7c>] (driver_register+0x78/0x12c) from [<c0008620>] (do_one_initcall+0x34/0x174)
	[   25.691826] [<c0008620>] (do_one_initcall+0x34/0x174) from [<c006dab0>] (sys_init_module+0xc20/0x18e0)
	[   25.701131] [<c006dab0>] (sys_init_module+0xc20/0x18e0) from [<c000df00>] (ret_fast_syscall+0x0/0x30)
	[   25.710336] ---[ end trace f64968a4a9d9fe8b ]---

I may be misinterpreting things, but this looks to be caused by the
reparenting. So the question is whether what I'm trying to do is valid or
if there is some other way to properly make the GART device the parent of
the DRM device.

Thanks,
Thierry

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk99WxIACgkQZ+BJyKLjJp+mUgCbBUW9l6runOKEqDiHKPUpxAHK
IU8AnAtf9hsgazkb/3FLlZLNCOgcBY5Q
=eTDV
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--

--===============2477958649242507229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============2477958649242507229==--
