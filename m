From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 1/4] iommu/tegra: gart: Don't unnecessarily allocate
 registers context
Date: Tue, 26 Sep 2017 17:15:15 +0300
Message-ID: <d75405bc-62c3-b26b-7ece-7300fc4a582a@gmail.com>
References: <cover.1499270277.git.digetx@gmail.com>
 <df570fb6649da6bc3b5f2a68afcb5471e6148269.1499270277.git.digetx@gmail.com>
 <20170926111950.GD23108@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170926111950.GD23108@ulmo>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 26.09.2017 14:19, Thierry Reding wrote:
> On Wed, Jul 05, 2017 at 07:29:45PM +0300, Dmitry Osipenko wrote:
>> GART looses it's state only in case of a deepest suspend level. Let's not
>> waste memory if machine doesn't support that suspend level.
>>
>> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/iommu/tegra-gart.c | 36 +++++++++++++++++++++++++-----------
>>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> I'm not sure about this. The savedata region uses 32 KiB of memory,
> which is really not a whole lot.
> 
> In addition, the suspend mode can be set in different places during the
> boot process, some of which fairly late. I'm concerned that this boot
> order dependency is going to come back to bite us eventually.
> 

Indeed, suspend mode is set after drivers been probed, my bad.

On the other hand LP0 support haven't been implemented for years, some of
drivers do not implement suspend/resume. So maybe it's worth to give up on LP0
entirely...

-- 
Dmitry
