From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v9 0/8] perf/amd/iommu: Enable multi-IOMMU support
Date: Wed, 15 Feb 2017 12:13:40 +0100
Message-ID: <20170215111340.myr3aecozzepxcx6@pd.tnic>
References: <1486456836-17428-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20170215101323.ecggpvbkbcqaq5xs@pd.tnic>
	<20170215104424.GA8207@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170215104424.GA8207@krava>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jiri Olsa <jolsa-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Jiri Olsa <jolsa-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 15, 2017 at 11:44:24AM +0100, Jiri Olsa wrote:
> does it say unsupported when you omit -a?

Yeah, it does dump the event name like it was counting but then it says
<not supported>. For example:

   <not supported>      amd_iommu_0/...

> [jolsa@krava perf]$ ./perf stat -e 'cpu/cpu-cycles/'
	 ^^^^^

Haha, I chuckle everytime I see this hostname :-)))

> > So, lemme ask perf tool people, can we guys make the -a thing default
> > when detect that we're running only uncore events which all should need
> > -a anyway?
> 
> it's possible, can't think of anything being hurt by this now..

Right, so Peter meant something simple like: you parse all events, see
that they're all uncore and enable system_wide if so.

I get the feeling that we want to do that for uncore-only events
anyway...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
