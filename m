From: "kernelci.org bot" <bot-ssFOTAMYnuFg9hUCZPvPmw@public.gmane.org>
Subject: next/master boot bisection: next-20181219 on r8a7796-m3ulcb
Date: Wed, 19 Dec 2018 23:25:11 -0800 (PST)
Message-ID: <5c1b43d7.1c69fb81.83c33.4d08@mx.google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4166725299162160480=="
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

--===============4166725299162160480==
Content-Type: multipart/alternative;
 boundary="===============2154827206612283128=="

--===============2154827206612283128==
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

next/master boot bisection: next-20181219 on r8a7796-m3ulcb

Summary:
  Start:      02fc169594e9 Add linux-next specific files for 20181219
  Details:    https://kernelci.org/boot/id/5c1a262459b51498440a8181
  Plain log:  https://storage.kernelci.org//next/master/next-20181219/arm64=
/defconfig/lab-baylibre/boot-r8a7796-m3ulcb.txt
  HTML log:   https://storage.kernelci.org//next/master/next-20181219/arm64=
/defconfig/lab-baylibre/boot-r8a7796-m3ulcb.html
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
  Target:     r8a7796-m3ulcb
  CPU arch:   arm64
  Lab:        lab-baylibre
  Config:     defconfig
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
# good: [ddfbab46539f2d37a9e9d357b054486b51f7dc27] Merge tag 'scsi-fixes' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect good ddfbab46539f2d37a9e9d357b054486b51f7dc27
# bad: [02fc169594e96f7c51c4f23114e12b7a18e85a0a] Add linux-next specific f=
iles for 20181219
git bisect bad 02fc169594e96f7c51c4f23114e12b7a18e85a0a
# good: [423ff56561dc1c3fdd7c51a6697cc30b8d18d49a] Merge remote-tracking br=
anch 'mtd/mtd/next'
git bisect good 423ff56561dc1c3fdd7c51a6697cc30b8d18d49a
# bad: [232006e511f040f8089f6112916434b0de707c89] Merge remote-tracking bra=
nch 'audit/next'
git bisect bad 232006e511f040f8089f6112916434b0de707c89
# good: [02c4fb0210dc2773e0d7f0a5a1b866986f8edc40] Merge branch 'linux-4.21=
' of git://github.com/skeggsb/linux into drm-next
git bisect good 02c4fb0210dc2773e0d7f0a5a1b866986f8edc40
# good: [7a934f6040a2002e0cbd5507b3b6608537344525] Merge remote-tracking br=
anch 'input/next'
git bisect good 7a934f6040a2002e0cbd5507b3b6608537344525
# good: [36357a3d5a9be1fef1d7ede3bf90bf470bdbbf9f] Merge remote-tracking br=
anch 'device-mapper/for-next'
git bisect good 36357a3d5a9be1fef1d7ede3bf90bf470bdbbf9f
# good: [a85d704d06d9643c5fb3a13744653d6b36c12f8b] Merge remote-tracking br=
anch 'regulator/for-next'
git bisect good a85d704d06d9643c5fb3a13744653d6b36c12f8b
# good: [d5530f072a98f3956a1fc91d800ad85a27c4509b] Merge remote-tracking br=
anch 'watchdog/master'
git bisect good d5530f072a98f3956a1fc91d800ad85a27c4509b
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
--===============2154827206612283128==
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
      <title>next/master boot bisection: next-20181219 on r8a7796-m3ulcb</t=
itle>
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
        <h1>next/master boot bisection: next-20181219 on r8a7796-m3ulcb</h1>
      </p>
      <p>
        <h2>Summary:</h2>
        <table>
          <tr><th>Start</th><td><pre>02fc169594e9 Add linux-next specific f=
iles for 20181219</pre></td></tr>
          <tr><th>Details</th><td><a href=3D"https://kernelci.org/boot/id/5=
c1a262459b51498440a8181">next-20181219</a></td></tr>
          <tr><th>Plain log</th><td><a href=3D"https://storage.kernelci.org=
//next/master/next-20181219/arm64/defconfig/lab-baylibre/boot-r8a7796-m3ulc=
b.txt">https://storage.kernelci.org//next/master/next-20181219/arm64/defcon=
fig/lab-baylibre/boot-r8a7796-m3ulcb.txt</a></td></tr>
          <tr><th>HTML log</th><td><a href=3D"https://storage.kernelci.org/=
/next/master/next-20181219/arm64/defconfig/lab-baylibre/boot-r8a7796-m3ulcb=
.html">https://storage.kernelci.org//next/master/next-20181219/arm64/defcon=
fig/lab-baylibre/boot-r8a7796-m3ulcb.html</a></td></tr>
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
          <tr><th>Target</th><td>r8a7796-m3ulcb</td></tr>
          <tr><th>CPU arch</th><td>arm64</td></tr>
          <tr><th>Lab</th><td>lab-baylibre</td></tr>
          <tr><th>Config</th><td>defconfig</td></tr>
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
# good: [ddfbab46539f2d37a9e9d357b054486b51f7dc27] Merge tag 'scsi-fixes' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect good ddfbab46539f2d37a9e9d357b054486b51f7dc27
# bad: [02fc169594e96f7c51c4f23114e12b7a18e85a0a] Add linux-next specific f=
iles for 20181219
git bisect bad 02fc169594e96f7c51c4f23114e12b7a18e85a0a
# good: [423ff56561dc1c3fdd7c51a6697cc30b8d18d49a] Merge remote-tracking br=
anch 'mtd/mtd/next'
git bisect good 423ff56561dc1c3fdd7c51a6697cc30b8d18d49a
# bad: [232006e511f040f8089f6112916434b0de707c89] Merge remote-tracking bra=
nch 'audit/next'
git bisect bad 232006e511f040f8089f6112916434b0de707c89
# good: [02c4fb0210dc2773e0d7f0a5a1b866986f8edc40] Merge branch 'linux-4.21=
' of git://github.com/skeggsb/linux into drm-next
git bisect good 02c4fb0210dc2773e0d7f0a5a1b866986f8edc40
# good: [7a934f6040a2002e0cbd5507b3b6608537344525] Merge remote-tracking br=
anch 'input/next'
git bisect good 7a934f6040a2002e0cbd5507b3b6608537344525
# good: [36357a3d5a9be1fef1d7ede3bf90bf470bdbbf9f] Merge remote-tracking br=
anch 'device-mapper/for-next'
git bisect good 36357a3d5a9be1fef1d7ede3bf90bf470bdbbf9f
# good: [a85d704d06d9643c5fb3a13744653d6b36c12f8b] Merge remote-tracking br=
anch 'regulator/for-next'
git bisect good a85d704d06d9643c5fb3a13744653d6b36c12f8b
# good: [d5530f072a98f3956a1fc91d800ad85a27c4509b] Merge remote-tracking br=
anch 'watchdog/master'
git bisect good d5530f072a98f3956a1fc91d800ad85a27c4509b
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
--===============2154827206612283128==--

--===============4166725299162160480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4166725299162160480==--
