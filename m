From: Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: flush IOTLB for specific domains only (v2)
Date: Fri, 19 May 2017 09:35:30 -0400
Message-ID: <1495200930.4360.6.camel@rutgers.edu>
References: <20170407102039.GW7266@8bytes.org>
 <1495188151-14358-1-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2112141829=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1495188151-14358-1-git-send-email-arindam.nath-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: arindam.nath-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: John.Bridgman-5C7GfCeVMHo@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org, michel-otUistvHUpPR7s880joybQ@public.gmane.org, Craig Stein <stein12c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org, Felix.Kuehling-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============2112141829==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-BlivSvaPNFHysyNDKbTM"


--=-BlivSvaPNFHysyNDKbTM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2017-05-19 at 15:32 +0530, arindam.nath-5C7GfCeVMHo@public.gmane.org wrote:
> From: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>
>=20
> Change History
> --------------
>=20
> v2: changes suggested by Joerg
> - add flush flag to improve efficiency of flush operation
>=20
> v1:
> - The idea behind flush queues is to defer the IOTLB flushing
>   for domains for which the mappings are no longer valid. We
>   add such domains in queue_add(), and when the queue size
>   reaches FLUSH_QUEUE_SIZE, we perform __queue_flush().
>=20
>   Since we have already taken lock before __queue_flush()
>   is called, we need to make sure the IOTLB flushing is
>   performed as quickly as possible.
>=20
>   In the current implementation, we perform IOTLB flushing
>   for all domains irrespective of which ones were actually
>   added in the flush queue initially. This can be quite
>   expensive especially for domains for which unmapping is
>   not required at this point of time.
>=20
>   This patch makes use of domain information in
>   'struct flush_queue_entry' to make sure we only flush
>   IOTLBs for domains who need it, skipping others.

Hi,

just a note, the patch also fixes "AMD-Vi: Completion-Wait loop timed
out" boot hang on my system (carrizo + iceland) [0,1,2]. Presumably the
old loop also tried to flush domains that included powered-off devices.

regards,
Jan

[0] https://github.com/RadeonOpenCompute/ROCK-Kernel-Driver/issues/20
[1] https://bugs.freedesktop.org/show_bug.cgi?id=3D101029
[2] https://bugzilla.redhat.com/show_bug.cgi?id=3D1448121

>=20
> Suggested-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu.c       | 27 ++++++++++++++++++++-------
>  drivers/iommu/amd_iommu_types.h |  2 ++
>  2 files changed, 22 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 63cacf5..1edeebec 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -2227,15 +2227,26 @@ static struct iommu_group *amd_iommu_device_group=
(struct device *dev)
> =20
>  static void __queue_flush(struct flush_queue *queue)
>  {
> -	struct protection_domain *domain;
> -	unsigned long flags;
>  	int idx;
> =20
> -	/* First flush TLB of all known domains */
> -	spin_lock_irqsave(&amd_iommu_pd_lock, flags);
> -	list_for_each_entry(domain, &amd_iommu_pd_list, list)
> -		domain_flush_tlb(domain);
> -	spin_unlock_irqrestore(&amd_iommu_pd_lock, flags);
> +	/* First flush TLB of all domains which were added to flush queue */
> +	for (idx =3D 0; idx < queue->next; ++idx) {
> +		struct flush_queue_entry *entry;
> +
> +		entry =3D queue->entries + idx;
> +
> +		/*
> +		 * There might be cases where multiple IOVA entries for the
> +		 * same domain are queued in the flush queue. To avoid
> +		 * flushing the same domain again, we check whether the
> +		 * flag is set or not. This improves the efficiency of
> +		 * flush operation.
> +		 */
> +		if (!entry->dma_dom->domain.already_flushed) {
> +			entry->dma_dom->domain.already_flushed =3D true;
> +			domain_flush_tlb(&entry->dma_dom->domain);
> +		}
> +	}
> =20
>  	/* Wait until flushes have completed */
>  	domain_flush_complete(NULL);
> @@ -2289,6 +2300,8 @@ static void queue_add(struct dma_ops_domain *dma_do=
m,
>  	pages     =3D __roundup_pow_of_two(pages);
>  	address >>=3D PAGE_SHIFT;
> =20
> +	dma_dom->domain.already_flushed =3D false;
> +
>  	queue =3D get_cpu_ptr(&flush_queue);
>  	spin_lock_irqsave(&queue->lock, flags);
> =20
> diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_ty=
pes.h
> index 4de8f41..4f5519d 100644
> --- a/drivers/iommu/amd_iommu_types.h
> +++ b/drivers/iommu/amd_iommu_types.h
> @@ -454,6 +454,8 @@ struct protection_domain {
>  	bool updated;		/* complete domain flush required */
>  	unsigned dev_cnt;	/* devices assigned to this domain */
>  	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
> +	bool already_flushed;	/* flag to avoid flushing the same domain again
> +				   in a single invocation of __queue_flush() */
>  };
> =20
>  /*

--=20
Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
--=-BlivSvaPNFHysyNDKbTM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEjGgSoFJq63cCYGKvY+M/tz9IsiAFAlke9KIACgkQY+M/tz9I
siCsJBAA3J63FOaebkCw8SMZEGWxPcVhPd1zoILhvVo+RpHZdMPw2SW/kuIlbzX5
4HAtMageu26c1TVLMg969rCrbkgpU26Dv4kLDbi31266IDeTPw7dAOoAuwCZ7QhC
fMd8diHTUbKpl83WFca/NWyxCwnebdaX5LdCnA/5sEIYKv7ou2NtPuYwx5ZW6Ur9
YUmuKO6kPtHveKryI2djp1xVQycFRBzwlPgFuX5d2JM7oPc2ePSfKkubmo5sOcCT
CUaVff57egmmTtj8Y7ScnxgK7rnoDt/Hyk0tliYobrhZIXRUxAOihZWWk31HW9Mk
BeVv/wSnjzWTkoaneX+frLyDyRdfKDRo0bq1rV6BXiOws09bW2sJwLL+1CM6p0O9
goyD+sJnMHpIuuPUi487EfoQ/sLq/uHAphlsFK4ylZ8Zx6NOgezpkm1OCP5JxkIV
BiNP5xrEReSnSeFJLEQLPpZHRW8cUsH1SK+A/PtZa+t6tvl3Uhs4t5MDcoqc/M19
d+PN7WlpW1wpGeusE87PaTy0AHhuuVznxb90TSiHVWGEFDdgzjCzLpEJNDbtgTgc
EnLmgdu0FHRobxVyncMBnuzzjg7CbhMqVR9ZyNLA2SQHyd7qh2+kTP5vB8XJPuc9
buGvoGfN8P0fa0EBJkw7+fJDg5JZ6uMQmjEd9wqoCiofeDSROko=
=HN3S
-----END PGP SIGNATURE-----

--=-BlivSvaPNFHysyNDKbTM--


--===============2112141829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2112141829==--
