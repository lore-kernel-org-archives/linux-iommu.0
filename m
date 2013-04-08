From: Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH V3] iommu/amd: Add logic to decode AMD IOMMU event flag
Date: Mon, 8 Apr 2013 10:43:45 -0500
Message-ID: <5162E5B1.2030707@amd.com>
References: <1364947610-3327-1-git-send-email-suravee.suthikulpanit@amd.com>
	<02D2024799561B48A732D1A51CB969E81959AF3E@sausexdag04.amd.com>
	<20130408145003.GC4723@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3162259264137799675=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130408145003.GC4723-fF5Pk5pvG8Y@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============3162259264137799675==
Content-Type: multipart/alternative;
	boundary="------------070605090806070903080808"

--------------070605090806070903080808
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/2013 9:50 AM, Borislav Petkov wrote:
> Independent from Joerg's feedback on this, I have only one question:
> you're not seriously considering on dumping this "Note:..." line above
> on*every*  IO-PF, right?
Boris,

If you think that is obvious, I can get rid of this also.

Suravee

--------------070605090806070903080808
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">On 4/8/2013 9:50 AM, Borislav Petkov
      wrote:<br>
    </div>
    <blockquote cite="mid:20130408145003.GC4723-fF5Pk5pvG8Y@public.gmane.org" type="cite">
      <pre wrap="">Independent from Joerg's feedback on this, I have only one question:
you're not seriously considering on dumping this "Note:..." line above
on <b class="moz-txt-star"><span class="moz-txt-tag">*</span>every<span class="moz-txt-tag">*</span></b> IO-PF, right?</pre>
    </blockquote>
    Boris, <br>
    <br>
    If you think that is obvious, I can get rid of this also. <br>
    <br>
    Suravee<br>
  </body>
</html>

--------------070605090806070903080808--

--===============3162259264137799675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3162259264137799675==--
