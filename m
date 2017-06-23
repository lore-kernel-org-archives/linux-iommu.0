From: Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
Subject: Re: [PATCH v1 3/3] iommu/amd: Optimize the IOMMU queue flush
Date: Fri, 23 Jun 2017 10:20:47 -0400
Message-ID: <1498227647.17007.31.camel@rutgers.edu>
References: <20170605195203.11512.20579.stgit@tlendack-t1.amdoffice.net>
	<20170605195235.11512.52995.stgit@tlendack-t1.amdoffice.net>
	<MWHPR12MB15181A6A020ACA2F53DF70339CCB0@MWHPR12MB1518.namprd12.prod.outlook.com>
	<1496954035.4188.1.camel@rutgers.edu>
	<1498062018.17007.6.camel@rutgers.edu>
	<bf685f44-019c-4c21-25d4-6a6ea647b7cc@amd.com>
	<1498079371.17007.18.camel@rutgers.edu>
	<20170622092053.GV30388@8bytes.org>
	<1498144389.17007.25.camel@rutgers.edu>
	<20170622215735.GW30388@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7386839420939824918=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170622215735.GW30388-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, "Nath,
	Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Craig Stein <stein12c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============7386839420939824918==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-KfdcvT3cnNT8K5kS0x0m"


--=-KfdcvT3cnNT8K5kS0x0m
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2017-06-22 at 23:57 +0200, Joerg Roedel wrote:
> On Thu, Jun 22, 2017 at 11:13:09AM -0400, Jan Vesely wrote:
> > It looks like I tested different patches.
> > linux-4.10.17 with both
> > "iommu/amd: Optimize iova queue flushing"
>=20
> This patch isn't in my tree and will not go upstream.
>=20
> > and
> > "iommu/amd: Disable previously enabled IOMMUs at boot"
>=20
> This patch solves a different problem.
>=20
> > (I haven't tested the series independently)
> >=20
> > works OK. The machine booted successfully and I was able to test clover
> > based OpenCL and simple OpenGL on both iGPU(carrizo) and dGPU(iceland).
>=20
> For a conclusive test please use what is in the iommu-tree, as this is
> what I plan to send upstream. You can use the 'next' branch of
>=20
> 	git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git

Tested commit c71bf5f133056aae71e8ae7ea66240574bd44f54.

The machine boots and runs OK, although it takes few minutes to boot up
(looks USB related).

OpenGL and OpenCL run OK on both GPUs.

I was able to trigger "Completion-Wait loop timed out" messages in the
following situation:
Hung OpenCL task running on dGPU.
dGPU goes to sleep.
sigterm to hung task.
it seems to recover OK after the dGPU is powered back on

dmesg:
[ 1628.049683] amdgpu: [powerplay] VI should always have 2 performance leve=
ls
[ 1628.845195] amdgpu 0000:07:00.0: GPU pci config reset
[ 1667.270351] amdgpu 0000:07:00.0: couldn't schedule ib on ring <sdma0>
[ 1667.270437] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (=
-22)
[ 1667.270491] [drm:amd_sched_main [amdgpu]] *ERROR* Failed to run job!
[ 1667.270505] amdgpu 0000:07:00.0: couldn't schedule ib on ring <sdma0>
[ 1667.270556] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (=
-22)
[ 1667.270607] [drm:amd_sched_main [amdgpu]] *ERROR* Failed to run job!
[ 1667.270614] amdgpu 0000:07:00.0: couldn't schedule ib on ring <sdma0>
[ 1667.270664] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (=
-22)
[ 1667.270714] [drm:amd_sched_main [amdgpu]] *ERROR* Failed to run job!
[ 1667.270721] amdgpu 0000:07:00.0: couldn't schedule ib on ring <sdma0>
[ 1667.270770] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (=
-22)
[ 1667.270846] [drm:amd_sched_main [amdgpu]] *ERROR* Failed to run job!
[ 1667.270868] amdgpu 0000:07:00.0: couldn't schedule ib on ring <sdma0>
[ 1667.270922] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (=
-22)
[ 1667.270982] [drm:amd_sched_main [amdgpu]] *ERROR* Failed to run job!
[ 1667.270992] amdgpu 0000:07:00.0: couldn't schedule ib on ring <sdma0>
[ 1667.271043] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (=
-22)
[ 1667.271096] [drm:amd_sched_main [amdgpu]] *ERROR* Failed to run job!
[ 1667.271109] amdgpu 0000:07:00.0: couldn't schedule ib on ring <sdma0>
[ 1667.271164] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (=
-22)
[ 1667.271230] [drm:amd_sched_main [amdgpu]] *ERROR* Failed to run job!
[ 1667.271245] amdgpu 0000:07:00.0: couldn't schedule ib on ring <sdma0>
[ 1667.271338] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (=
-22)
[ 1667.271394] [drm:amd_sched_main [amdgpu]] *ERROR* Failed to run job!
[ 1667.271403] amdgpu 0000:07:00.0: couldn't schedule ib on ring <sdma0>
[ 1667.271458] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (=
-22)
[ 1667.271518] [drm:amd_sched_main [amdgpu]] *ERROR* Failed to run job!
[ 1667.271533] amdgpu 0000:07:00.0: couldn't schedule ib on ring <sdma0>
[ 1667.271588] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (=
-22)
[ 1667.271644] [drm:amd_sched_main [amdgpu]] *ERROR* Failed to run job!
[ 1667.426742] AMD-Vi: Completion-Wait loop timed out
[ 1667.570025] AMD-Vi: Completion-Wait loop timed out
[ 1667.713326] AMD-Vi: Completion-Wait loop timed out
[ 1667.867561] AMD-Vi: Completion-Wait loop timed out
[ 1668.010886] AMD-Vi: Completion-Wait loop timed out
[ 1668.154207] AMD-Vi: Completion-Wait loop timed out
[ 1668.283193] AMD-Vi: Event logged [
[ 1668.283201] IOTLB_INV_TIMEOUT device=3D07:00.0 address=3D0x000000040ce6e=
240]
[ 1668.430357] AMD-Vi: Completion-Wait loop timed out
[ 1668.581169] AMD-Vi: Completion-Wait loop timed out
[ 1668.718046] AMD-Vi: Completion-Wait loop timed out
[ 1668.854914] AMD-Vi: Completion-Wait loop timed out
[ 1668.991774] AMD-Vi: Completion-Wait loop timed out
[ 1669.128638] AMD-Vi: Completion-Wait loop timed out
[ 1669.272391] AMD-Vi: Completion-Wait loop timed out
[ 1669.285193] AMD-Vi: Event logged [
[ 1669.285200] IOTLB_INV_TIMEOUT device=3D07:00.0 address=3D0x000000040ce6e=
2b0]
[ 1669.285756] [drm] PCIE GART of 3072M enabled (table at 0x000000000004000=
0).
[ 1669.288274] amdgpu: [powerplay] can't get the mac of 5
[ 1669.302600] [drm] ring test on 0 succeeded in 16 usecs
[ 1669.302987] [drm] ring test on 1 succeeded in 17 usecs
[ 1669.303037] [drm] ring test on 2 succeeded in 21 usecs
[ 1669.303063] [drm] ring test on 3 succeeded in 10 usecs
[ 1669.303088] [drm] ring test on 4 succeeded in 10 usecs
[ 1669.303114] [drm] ring test on 5 succeeded in 10 usecs
[ 1669.303142] [drm] ring test on 6 succeeded in 11 usecs
[ 1669.303167] [drm] ring test on 7 succeeded in 10 usecs
[ 1669.303195] [drm] ring test on 8 succeeded in 11 usecs
[ 1669.303229] [drm] ring test on 9 succeeded in 3 usecs
[ 1669.303235] [drm] ring test on 10 succeeded in 3 usecs
[ 1675.029247] amdgpu: [powerplay] VI should always have 2 performance leve=
ls
[ 1675.823322] amdgpu 0000:07:00.0: GPU pci config reset

lspci:
07:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI]
Topaz XT [Radeon R7 M260/M265 / M340/M360 / M440/M445] (rev ff)

Jan

>=20
> to get all patches, including my flush optimization series.
>=20
>=20
> Thanks,
>=20
> 	Joerg
>=20

--=-KfdcvT3cnNT8K5kS0x0m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJZTSO/AAoJEGPjP7c/SLIg65EQAMmEge6bNDghKqWunenapqoj
LOdGBa/I2sPr3CKwFjILmFk8nFgdwJJKCfmJ6VvHA+CWJ6dN81cjYpTvt8Jug1fx
0dSfCasQOM9/vKy5yqGHIr7grX0H3pXWipDsVFbUvjcCSYQcWzgZGyMZBmOmD6Za
r072no2OTnRnEvLFXL/8uUjaFR/SXx10FQqwzuJUhnWnV1A4kmteSYEUwQBoLNsc
tgCyQrlglFMjL+l/elO3II0dY6L7SQcvZGuNsRmB4J4nI9rkaRQ22VbjwinH2N5w
1jdy4Ly7wFCFdzi8ucaG29kuHpMeNIzlde99cvvtby/g2bWIdNv/2JhseZn2Hfa7
icObKSLsqGmVWBCUYeHXg5fMzOBG98UnKF/anulNNiyPSCNLuAbg5rTxxqVcIKsq
7vK0wtl0hL+SIiBA4l5aK2XAVtWEzxmyuHmpjkmNJBAMx3vfrc6Y2UG7XOHuQT4M
/S1L+wwOrcWktHZ1KztarKandeZ41+7nq2ENdNaTd74fki1oC7fqz++55sKKQyb2
/Oe8/7CspPys/9EfDCsazb2xxlqRmK3wqN6BOszV1Su++QoFzvQRJUsZkzr78RkW
MFcmZLhGqfWJV5O4SYvBIS9NGBpT/oD7otcgqTySHxnYE6VGKtmaXMRRNXXpo0mS
LZ2Y+rqJ/oy7RGcYIl+k
=uP9I
-----END PGP SIGNATURE-----

--=-KfdcvT3cnNT8K5kS0x0m--


--===============7386839420939824918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7386839420939824918==--
