From: John David Anglin <dave.anglin-CzeTG9NwML0@public.gmane.org>
Subject: Re: ARM64 boot failure on espressobin with 5.0.0-rc6
	(1f947a7a011fcceb14cb912f5481a53b18f1879a)
Date: Fri, 15 Feb 2019 10:40:08 -0500
Message-ID: <d0c7d027-5032-89ae-cb8d-b84b13d00912@bell.net>
References: <bd202e22-c23e-ddf1-ef33-e60896465a5a@bell.net>
	<6d11c3cf-ce21-f1d6-df6f-8678f4159e3c@arm.com>
	<20190214173642.GA2704@lst.de>
	<fd389e6a-b10c-77fb-ac79-b15ffd805a7d@arm.com>
	<5ec6d5ed-7d5a-f313-fc31-17e61c16e9fc@bell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1801150277735071468=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5ec6d5ed-7d5a-f313-fc31-17e61c16e9fc-CzeTG9NwML0@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is a multi-part message in MIME format.
--===============1801150277735071468==
Content-Type: multipart/alternative;
 boundary="------------331E78D6089B999CBA9C9AC0"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------331E78D6089B999CBA9C9AC0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 2019-02-15 10:22 a.m., John David Anglin wrote:
> On 2019-02-14 12:58 p.m., Robin Murphy wrote:
>> Hmm, having felt brave enough to take a closer look, it might actually be as simple as this - Dave, are you able to give the diff below a spin?
> Still crashes but in slightly different spot:
>
I think I see what's wrong.

Dave

-- 
John David Anglin  dave.anglin-CzeTG9NwML0@public.gmane.org


--------------331E78D6089B999CBA9C9AC0
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">On 2019-02-15 10:22 a.m., John David
      Anglin wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:5ec6d5ed-7d5a-f313-fc31-17e61c16e9fc-CzeTG9NwML0@public.gmane.org">
      <pre class="moz-quote-pre" wrap="">On 2019-02-14 12:58 p.m., Robin Murphy wrote:
</pre>
      <blockquote type="cite" style="color: #000000;">
        <pre class="moz-quote-pre" wrap="">Hmm, having felt brave enough to take a closer look, it might actually be as simple as this - Dave, are you able to give the diff below a spin?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">Still crashes but in slightly different spot:

</pre>
    </blockquote>
    I think I see what's wrong.<br>
    <br>
    Dave<br>
    <pre class="moz-signature" cols="144">-- 
John David Anglin  <a class="moz-txt-link-abbreviated" href="mailto:dave.anglin-CzeTG9NwML0@public.gmane.org">dave.anglin-CzeTG9NwML0@public.gmane.org</a></pre>
  </body>
</html>

--------------331E78D6089B999CBA9C9AC0--

--===============1801150277735071468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1801150277735071468==--
