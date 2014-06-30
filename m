From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC/PATCH 3/7] iopoll: Introduce memory-mapped IO polling macros
Date: Mon, 30 Jun 2014 21:46:37 +0200
Message-ID: <20140630194631.GD32594@mithrandir>
References: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
	<1404147116-4598-4-git-send-email-ohaugan@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3672351613892261140=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1404147116-4598-4-git-send-email-ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Matt Wagantall <mattw-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, vgandhi-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============3672351613892261140==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dzs2zDY0zgkG72+7"
Content-Disposition: inline


--Dzs2zDY0zgkG72+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 30, 2014 at 09:51:52AM -0700, Olav Haugan wrote:
[...]
> diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
[...]
> +/**
> + * readl_poll_timeout - Periodically poll an address until a condition is met or a timeout occurs
> + * @addr: Address to poll
> + * @val: Variable to read the value into
> + * @cond: Break condition (usually involving @val)
> + * @sleep_us: Maximum time to sleep between reads in uS (0 tight-loops)

s/uS/us/ here and elsewhere. S is the symbol for Siemens.

> + * @timeout_us: Timeout in uS, 0 means never timeout
> + *
> + * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
> + * case, the last read value at @addr is stored in @val. Must not
> + * be called from atomic context if sleep_us or timeout_us are used.
> + */
> +#define readl_poll_timeout(addr, val, cond, sleep_us, timeout_us) \
> +({ \
> +	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us); \
> +	might_sleep_if(timeout_us); \
> +	for (;;) { \
> +		(val) = readl(addr); \
> +		if (cond) \
> +			break; \
> +		if (timeout_us && ktime_compare(ktime_get(), timeout) > 0) { \
> +			(val) = readl(addr); \
> +			break; \
> +		} \
> +		if (sleep_us) \
> +			usleep_range(DIV_ROUND_UP(sleep_us, 4), sleep_us); \
> +	} \
> +	(cond) ? 0 : -ETIMEDOUT; \
> +})

Why can't these be functions?

Thierry

--Dzs2zDY0zgkG72+7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTsb6bAAoJEN0jrNd/PrOhyQsP/R3AeSu8vE/d8c/uCFu4+cJO
yFyrP4iOVHuAKQSrz472/ETOdDkw0s/bBQv/qSrCJQrkMqObZhYIL/FT/lURy89b
NUCLacvjrvGhF/ToGsbDb89GH6AdD0veO8bBy5AYxF685tZ9H9TZaGgS+gLfyVbC
ZqMlT9uCSFW4RsNQJCs+KkC67a0tBDGy0Fv8EauP+NlGXXhhpirT2Lb2xu627FyY
f/ucDWHeZ/OS0YJ1GDmP6OUSoSxQaQWzvUKPngyQRqAF5dGt9eInxKmWrsYFsx5W
Lmxv+fseiWv6Q35e2qEL8UHEDklL502FYKCcKlVp7OYYCO7SXy6ayzapwUUmNzlh
QVUdYCYSkJeI6PWHz586Pk52Gu03+0YhS/nqRb007TMqrbMdEuoNwOcSF2pz4wV3
bqE7wntBQTiLdtdFodrzjOc2gZAmsrlB2XKvgQba4uBLpW0ypy1TwjatDnAXFIJD
r1untzvIcWcz1bzz7tjA1mZwfMTfpsVtlVXl2/nIW7YYQVS+KrQUaglRtRt8qjLa
1+gdlMw1SAQKGm6TUVRvuqA5ojXV0H2ybRY8nYru1N9/zqDFTFo1/Jd2jfPuf761
tI8tEcRZNlGuYW/Y0Cr6IJdvts6xTjMVX4/b+Rki5miAs3ofrZzwDKvbYYxmWA+V
tc6h4q9T5rOQ9F7v+a1H
=XiTW
-----END PGP SIGNATURE-----

--Dzs2zDY0zgkG72+7--

--===============3672351613892261140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3672351613892261140==--
