From: Yves-Alexis Perez <corsac-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 0/5] Add Intel IOMMU debugfs support
Date: Sun, 18 Feb 2018 23:15:32 +0100
Message-ID: <1518992132.2542.5.camel@debian.org>
References: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
	<20180213140303.42mbzfxpypljy37l@8bytes.org>
	<20180213214002.GA27066@otc-nc-03>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4391942610758473944=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180213214002.GA27066@otc-nc-03>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Ravi V Shankar <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============4391942610758473944==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-Lsf0i4rxIq4C6g1RKkBY"


--=-Lsf0i4rxIq4C6g1RKkBY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-02-13 at 13:40 -0800, Raj, Ashok wrote:
> This version has only hw dumps for now, but we plan to add some other thi=
ngs
> like walking 2nd level page-tables, or get some SVM specific data from th=
e=20
> driver in the future.=20

Hi,

I'm not sure how much you know about chipsec [1], but with a oneliner [2] y=
ou
can have it print a lot of data from Vt-d configuration, including page
tables. As far as I remember, it doesn't need access to /dev/mem (but I gid=
n't
dig to check how it does it).

It might still be useful to have everything from debugfs because it'll alwa=
ys
be consistent with the current running kernel, but at least it might help
users reporting bugs.

[1] https://github.com/chipsec/chipsec
[2] http://paste.debian.net/1010105
--=20
Yves-Alexis
--=-Lsf0i4rxIq4C6g1RKkBY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEE8vi34Qgfo83x35gF3rYcyPpXRFsFAlqJ+wUACgkQ3rYcyPpX
RFvEuQf+NF2yWLkXIM6/XmEXZGQboq4coTLy06M/aT/fQfeUAehE2rBhWQXkmJqF
JXKFuuy6BXoQ1WW4qq6r/1tanadjeRSDTT2PloE1H/g9wppk9tqXG9S/Dqfzhbjo
0dc1Ctl7skiO3ioBH77BI5KhjFXBJay9YMvvoNYHg4Fud+M/Ga62IYQUCaa4x2Xp
mWnLJzY4EPZhQmv1o+ozBVFBltQh2tUER3+W0FHy95OuEv4GaSNhsfrDqhKa0B6a
+j+278FwoidB9kk8LVrG3xFChl7SGF+r2DCsfCMKHaDJaMvWioTOxaqEwIErU9gX
C90bwed2cfMu31qNmdnkxG1cuKVenA==
=egRp
-----END PGP SIGNATURE-----

--=-Lsf0i4rxIq4C6g1RKkBY--

--===============4391942610758473944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4391942610758473944==--
