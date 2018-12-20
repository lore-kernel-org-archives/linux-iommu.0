From: "kernelci.org bot" <bot-ssFOTAMYnuFg9hUCZPvPmw@public.gmane.org>
Subject: next/master boot bisection: next-20181220 on tegra124-nyan-big
Date: Thu, 20 Dec 2018 10:14:24 -0800 (PST)
Message-ID: <5c1bdc00.1c69fb81.43f6c.9225@mx.google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7096869641478231079=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, guillaume.tucker-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, matthew.hart-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============7096869641478231079==
Content-Type: multipart/alternative;
 boundary="===============2843772672283829003=="

--===============2843772672283829003==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

next/master boot bisection: next-20181220 on tegra124-nyan-big

Summary:
  Start:      1efde6eb1819 Add linux-next specific files for 20181220
  Details:    https://kernelci.org/boot/id/5c1b9ce459b514bfcd0a8184
  Plain log:  https://storage.kernelci.org//next/master/next-20181220/arm/t=
egra_defconfig/lab-collabora/boot-tegra124-nyan-big.txt
  HTML log:   https://storage.kernelci.org//next/master/next-20181220/arm/t=
egra_defconfig/lab-collabora/boot-tegra124-nyan-big.html
  Result:     641fb0efbff0 iommu/of: Don't call iommu_ops->add_device direc=
tly

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       next
  URL:        http://git.kernel.org/pub/scm/linux/kernel/git/next/linux-nex=
t.git
  Branch:     master
  Target:     tegra124-nyan-big
  CPU arch:   arm
  Lab:        lab-collabora
  Config:     tegra_defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 641fb0efbff063ed57f108c2eb4a4d26dbd5badd
Author: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Date:   Wed Dec 5 14:39:45 2018 +0100

    iommu/of: Don't call iommu_ops->add_device directly
    =

    Make sure to invoke this call-back through the proper
    function of the IOMMU-API.
    =

    Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index dbe73456f1a1..d8947b28db2d 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -222,10 +222,10 @@ const struct iommu_ops *of_iommu_configure(struct dev=
ice *dev,
 	}
 	/*
 	 * If we have reason to believe the IOMMU driver missed the initial
-	 * add_device callback for dev, replay it to get things in order.
+	 * probe for dev, replay it to get things in order.
 	 */
-	if (ops && ops->add_device && dev->bus && !device_iommu_mapped(dev))
-		err =3D ops->add_device(dev);
+	if (dev->bus && !device_iommu_mapped(dev))
+		err =3D iommu_probe_device(dev);
 =

 	/* Ignore all other errors apart from EPROBE_DEFER */
 	if (err =3D=3D -EPROBE_DEFER) {
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [c5c08bed843c2b2c048c16d1296d7631d7c1620e] virtio: fix test build a=
fter uio.h change
git bisect good c5c08bed843c2b2c048c16d1296d7631d7c1620e
# bad: [1efde6eb181908e1095b4a5db90af0c024016bec] Add linux-next specific f=
iles for 20181220
git bisect bad 1efde6eb181908e1095b4a5db90af0c024016bec
# good: [6580aac4d9913a22e269d7df8db1f9efb8d7fe14] Merge remote-tracking br=
anch 'crypto/master'
git bisect good 6580aac4d9913a22e269d7df8db1f9efb8d7fe14
# bad: [75f962d8fe5279ac9e64f3d411b8e38b84da8d6b] Merge remote-tracking bra=
nch 'spi/for-next'
git bisect bad 75f962d8fe5279ac9e64f3d411b8e38b84da8d6b
# good: [d675ba4b9e6ccd782e4db9109cbab708a85b8ff8] Merge tag 'drm-msm-next-=
2018-12-12' of git://people.freedesktop.org/~robclark/linux into drm-next
git bisect good d675ba4b9e6ccd782e4db9109cbab708a85b8ff8
# good: [6173f57441f9c05050aad441a2188eaabbfea7a0] Merge remote-tracking br=
anch 'block/for-next'
git bisect good 6173f57441f9c05050aad441a2188eaabbfea7a0
# good: [1531a9f0415ba8ea0f4e31d6f5a1ef059d19dc6d] Merge remote-tracking br=
anch 'regulator/for-next'
git bisect good 1531a9f0415ba8ea0f4e31d6f5a1ef059d19dc6d
# bad: [e2267b2875b0798814d0a76a304318e0c6d60c3e] Merge remote-tracking bra=
nch 'vfio/next'
git bisect bad e2267b2875b0798814d0a76a304318e0c6d60c3e
# good: [96ae0a1f40d405f8f0221f4fa8b9b2ef4bbbc01e] Merge remote-tracking br=
anch 'watchdog/master'
git bisect good 96ae0a1f40d405f8f0221f4fa8b9b2ef4bbbc01e
# bad: [d2e1a003af569e912d5f115a3c20b89a19f5caa0] ACPI/IORT: Don't call iom=
mu_ops->add_device directly
git bisect bad d2e1a003af569e912d5f115a3c20b89a19f5caa0
# good: [9b468f7d9cf1f089b7287865776eb100504681b7] iommu/arm-smmu: Use help=
er functions to access dev->iommu_fwspec
git bisect good 9b468f7d9cf1f089b7287865776eb100504681b7
# good: [170ecbd5ff09aa9c8c1025a8563f76e01a24bb50] iommu/of: Use device_iom=
mu_mapped()
git bisect good 170ecbd5ff09aa9c8c1025a8563f76e01a24bb50
# good: [f884f6ee62604aec60fe1760f94724be192d97c0] dmaengine: sh: rcar-dmac=
: Use device_iommu_mapped()
git bisect good f884f6ee62604aec60fe1760f94724be192d97c0
# good: [cc5aed44a3a8e4fca721636cf881a52f8d68a098] iommu: Consolitate ->add=
/remove_device() calls
git bisect good cc5aed44a3a8e4fca721636cf881a52f8d68a098
# bad: [641fb0efbff063ed57f108c2eb4a4d26dbd5badd] iommu/of: Don't call iomm=
u_ops->add_device directly
git bisect bad 641fb0efbff063ed57f108c2eb4a4d26dbd5badd
# first bad commit: [641fb0efbff063ed57f108c2eb4a4d26dbd5badd] iommu/of: Do=
n't call iommu_ops->add_device directly
---------------------------------------------------------------------------=
----
--===============2843772672283829003==
Content-Type: text/html; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

<!doctype html>
<html lang=3D"en">
    <head>
      <meta charset=3D"utf-8">
      <style>
h1 {
  font-size: 1.1em;
}
h2 {
  font-size: 1.0em;
}
table {
  border: none;
}
th {
  font-weight: bold;
  padding: 4px 10px 4px 10px;
  text-align: left;
  vertical-align: bottom;
}
td {
  vertical-align: bottom;
  padding: 4px;
}
pre {
  display: inline;
}
div.disclaimer {
  background-color: #eeeeee;
  width: 480px;
  padding: 2px 8px 2px 8px;
  font-size: 0.8em;
}
      </style>
      <title>next/master boot bisection: next-20181220 on tegra124-nyan-big=
</title>
    </head>
    <body>
      <div class=3D"disclaimer">
        <p>
          This automated bisection report was sent to you on the basis that=
 you
          may be involved with the breaking commit it has found.  No manual
          investigation has been done to verify it, and the root cause of t=
he
          problem may be somewhere else.
        </p>
        <p>
          Hope this helps!
        </p>
      </div>
      <p>
        <h1>next/master boot bisection: next-20181220 on tegra124-nyan-big<=
/h1>
      </p>
      <p>
        <h2>Summary:</h2>
        <table>
          <tr><th>Start</th><td><pre>1efde6eb1819 Add linux-next specific f=
iles for 20181220</pre></td></tr>
          <tr><th>Details</th><td><a href=3D"https://kernelci.org/boot/id/5=
c1b9ce459b514bfcd0a8184">next-20181220</a></td></tr>
          <tr><th>Plain log</th><td><a href=3D"https://storage.kernelci.org=
//next/master/next-20181220/arm/tegra_defconfig/lab-collabora/boot-tegra124=
-nyan-big.txt">https://storage.kernelci.org//next/master/next-20181220/arm/=
tegra_defconfig/lab-collabora/boot-tegra124-nyan-big.txt</a></td></tr>
          <tr><th>HTML log</th><td><a href=3D"https://storage.kernelci.org/=
/next/master/next-20181220/arm/tegra_defconfig/lab-collabora/boot-tegra124-=
nyan-big.html">https://storage.kernelci.org//next/master/next-20181220/arm/=
tegra_defconfig/lab-collabora/boot-tegra124-nyan-big.html</a></td></tr>
          <tr><th>Result</th><td><pre>641fb0efbff0 iommu/of: Don't call iom=
mu_ops->add_device directly</pre></td></tr>
        </table>
      </p>
      <p>
        <h2>Checks:</h2>
        <table>
          <tr><th>revert</th><td>PASS</td></tr>
          <tr><th>verify</th><td>PASS</td></tr>
        </table>
      </p>
      <p>
        <h2>Parameters:</h2>
        <table>
          <tr><th>Tree</th><td>next</td></tr>
          <tr><th>URL</th><td>http://git.kernel.org/pub/scm/linux/kernel/gi=
t/next/linux-next.git</td></tr>
          <tr><th>Branch</th><td>master</td></tr>
          <tr><th>Target</th><td>tegra124-nyan-big</td></tr>
          <tr><th>CPU arch</th><td>arm</td></tr>
          <tr><th>Lab</th><td>lab-collabora</td></tr>
          <tr><th>Config</th><td>tegra_defconfig</td></tr>
          <tr><th>Test suite</th><td>boot</td></tr>
        </table>
      </p>
      <p>
        <h2>Breaking commit found:</h2>
        <pre>commit 641fb0efbff063ed57f108c2eb4a4d26dbd5badd
Author: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Date:   Wed Dec 5 14:39:45 2018 +0100

    iommu/of: Don't call iommu_ops->add_device directly
    =

    Make sure to invoke this call-back through the proper
    function of the IOMMU-API.
    =

    Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index dbe73456f1a1..d8947b28db2d 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -222,10 +222,10 @@ const struct iommu_ops *of_iommu_configure(struct dev=
ice *dev,
 	}
 	/*
 	 * If we have reason to believe the IOMMU driver missed the initial
-	 * add_device callback for dev, replay it to get things in order.
+	 * probe for dev, replay it to get things in order.
 	 */
-	if (ops && ops->add_device && dev->bus && !device_iommu_mapped(dev))
-		err =3D ops->add_device(dev);
+	if (dev->bus && !device_iommu_mapped(dev))
+		err =3D iommu_probe_device(dev);
 =

 	/* Ignore all other errors apart from EPROBE_DEFER */
 	if (err =3D=3D -EPROBE_DEFER) {</pre>
      </p>
      <p>
        <h2>Git bisection log:</h2>
        <pre>
git bisect start
# good: [c5c08bed843c2b2c048c16d1296d7631d7c1620e] virtio: fix test build a=
fter uio.h change
git bisect good c5c08bed843c2b2c048c16d1296d7631d7c1620e
# bad: [1efde6eb181908e1095b4a5db90af0c024016bec] Add linux-next specific f=
iles for 20181220
git bisect bad 1efde6eb181908e1095b4a5db90af0c024016bec
# good: [6580aac4d9913a22e269d7df8db1f9efb8d7fe14] Merge remote-tracking br=
anch 'crypto/master'
git bisect good 6580aac4d9913a22e269d7df8db1f9efb8d7fe14
# bad: [75f962d8fe5279ac9e64f3d411b8e38b84da8d6b] Merge remote-tracking bra=
nch 'spi/for-next'
git bisect bad 75f962d8fe5279ac9e64f3d411b8e38b84da8d6b
# good: [d675ba4b9e6ccd782e4db9109cbab708a85b8ff8] Merge tag 'drm-msm-next-=
2018-12-12' of git://people.freedesktop.org/~robclark/linux into drm-next
git bisect good d675ba4b9e6ccd782e4db9109cbab708a85b8ff8
# good: [6173f57441f9c05050aad441a2188eaabbfea7a0] Merge remote-tracking br=
anch 'block/for-next'
git bisect good 6173f57441f9c05050aad441a2188eaabbfea7a0
# good: [1531a9f0415ba8ea0f4e31d6f5a1ef059d19dc6d] Merge remote-tracking br=
anch 'regulator/for-next'
git bisect good 1531a9f0415ba8ea0f4e31d6f5a1ef059d19dc6d
# bad: [e2267b2875b0798814d0a76a304318e0c6d60c3e] Merge remote-tracking bra=
nch 'vfio/next'
git bisect bad e2267b2875b0798814d0a76a304318e0c6d60c3e
# good: [96ae0a1f40d405f8f0221f4fa8b9b2ef4bbbc01e] Merge remote-tracking br=
anch 'watchdog/master'
git bisect good 96ae0a1f40d405f8f0221f4fa8b9b2ef4bbbc01e
# bad: [d2e1a003af569e912d5f115a3c20b89a19f5caa0] ACPI/IORT: Don't call iom=
mu_ops->add_device directly
git bisect bad d2e1a003af569e912d5f115a3c20b89a19f5caa0
# good: [9b468f7d9cf1f089b7287865776eb100504681b7] iommu/arm-smmu: Use help=
er functions to access dev->iommu_fwspec
git bisect good 9b468f7d9cf1f089b7287865776eb100504681b7
# good: [170ecbd5ff09aa9c8c1025a8563f76e01a24bb50] iommu/of: Use device_iom=
mu_mapped()
git bisect good 170ecbd5ff09aa9c8c1025a8563f76e01a24bb50
# good: [f884f6ee62604aec60fe1760f94724be192d97c0] dmaengine: sh: rcar-dmac=
: Use device_iommu_mapped()
git bisect good f884f6ee62604aec60fe1760f94724be192d97c0
# good: [cc5aed44a3a8e4fca721636cf881a52f8d68a098] iommu: Consolitate ->add=
/remove_device() calls
git bisect good cc5aed44a3a8e4fca721636cf881a52f8d68a098
# bad: [641fb0efbff063ed57f108c2eb4a4d26dbd5badd] iommu/of: Don't call iomm=
u_ops->add_device directly
git bisect bad 641fb0efbff063ed57f108c2eb4a4d26dbd5badd
# first bad commit: [641fb0efbff063ed57f108c2eb4a4d26dbd5badd] iommu/of: Do=
n't call iommu_ops->add_device directly</pre>
      </p>
    </body>
</html>
--===============2843772672283829003==--

--===============7096869641478231079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7096869641478231079==--
